//
//  SubscriptionManager.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit
import StoreKit

class SubscriptionManager: SubscriptionManagerProtocol {
    
    weak var delegate: SubscriptionDelegate?
    
    private(set) var purchasedProductIDs = Set<String>()
    var myProductIds: [String] = []
    var myProducts: [Product] = []
    var hasDidUnlocked: Bool {
        return self.purchasedProductIDs.isEmpty
    }
    var subscriptionID: String?
    let productIds = [SubscriptionID.yearly,
                      SubscriptionID.trialAndWeek]
    
    func loadProducts() async throws {
        do {
            self.myProducts = try await Product.products(for: productIds)
                .sorted(by: { $0.id > $1.id })
        } catch {
            print("Error fetching products: \(error)")
            throw error
        }
    }
    
    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
                self.myProductIds.append(transaction.productID)
                subscriptionID = transaction.productID
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
                myProductIds.removeAll { $0 == transaction.productID }
            }
        }
    }
    func purchase(_ choice: Subscription) async throws {
        var result: Product.PurchaseResult?
        switch choice {
        case .year:
            result = try await myProducts[0].purchase()
        case .trial:
            result = try await myProducts[1].purchase()
        }
        switch result {
        case let .success(.verified(transaction)):
            Task {
                await self.updatePurchasedProducts()
            }
            self.delegate?.update()
            await transaction.finish()
        case let .success(.unverified(_, error)):
            print("can't be verified")
            print(error)
        case .pending:
            print("pending")
        case .userCancelled:
            print("userCancelled")
        case .none:
            print("none")
        @unknown default:
        break
        }
    }
    @MainActor
    func restorePurchases() async throws {
        do {
            try await AppStore.sync()
            SKPaymentQueue.default().restoreCompletedTransactions()
            self.delegate?.update()
        } catch {
            print(error)
        }
    }
}
