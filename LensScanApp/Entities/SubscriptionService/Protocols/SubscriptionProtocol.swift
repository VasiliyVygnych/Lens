//
//  SubscriptionProtocol.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit
import StoreKit


protocol SubscriptionManagerProtocol {
    var delegate: SubscriptionDelegate? { get set }
    func updatePurchasedProducts() async
    var hasDidUnlocked: Bool { get }
    var myProductIds: [String] { get set }
    var myProducts: [Product] { get set }
    var subscriptionID: String? { get set }
    @MainActor
    func loadProducts() async throws
    func purchase(_ choice: Subscription) async throws
    func restorePurchases() async throws
    
}

protocol SubscriptionDelegate: AnyObject {
    func update()
    func getSubscriptionData(_ data: [String])
}
