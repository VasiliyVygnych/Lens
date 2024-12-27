//
//  OnboardingViewModel.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit

class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var coordinator: OnboardingCoordinatorProtocol?
    var subscription: SubscriptionManagerProtocol?
    var coreData: CoreManagerProtocol? 
    
//MARK: - CoreData
    
    func setAppModel(isLogin: Bool,
                     isSubscirbe: Bool) {
        coreData?.setAppModel(isLogin: isLogin,
                              isSubscirbe: isSubscirbe)
    }
    func getAppData() -> [AppData]? {
        return coreData?.getAppData()
    }
    func removeAppData() {
        coreData?.removeAppData()
    }
    
//MARK: - Coordinator
    
    func openOnboardindView() {
        coordinator?.createOnboardindView()
    }
    func openPayWallController() {
        coordinator?.createPayWallController()
    }
    func openWebViewController(mode: SettingsWebView) {
        coordinator?.createWebViewController(mode: mode)
    }
    func openTabBar() {
        coordinator?.initialTabBar()
    }
    func openTabBar(botton: UIButton) {
        viewAnimate(view: botton,
                    duration: 0.2,
                    scale: 0.96)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.coordinator?.initialTabBar()
        }
    }
    
//MARK: - View
    
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            view.transform = CGAffineTransform(scaleX: scale,
                                               y: scale)
        }, completion: { finished in
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                view.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
            })
        })
    }
    
//MARK: - Subscription
    
    func delegate(_ delegate: SubscriptionDelegate) {
        subscription?.delegate = delegate
    }
    func loadProducts() {
        Task {
            try await subscription?.loadProducts()
//            checkSubscription()
            DispatchQueue.main.async { [weak self] in
                self?.subscriptionData()
            }
        }
    }
    func subscriptionData() {
        var price: [String] = []
        subscription?.myProducts.forEach({ product in
            price.append(product.displayPrice)
        })
        subscription?.delegate?.getSubscriptionData(price)
    }
    func subscribe(to subscription: Subscription) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            switch subscription {
            case .year:
                Task {
                    try await self?.subscription?.purchase(subscription)
                }
            case .trial:
                Task {
                    try await self?.subscription?.purchase(subscription)
                }
            }
        }
    }
    func restoreSubscription() {
        Task {
            try await subscription?.restorePurchases()
        }
    }
    
    
    
    
    
    func removeLetters(from input: String) -> Double? {
        let regex = try! NSRegularExpression(pattern: "[^0-9.]",
                                             options: [])
        let range = NSRange(location: 0,
                            length: input.utf16.count)
        let result = regex.stringByReplacingMatches(in: input,
                                                    options: [],
                                                    range: range,
                                                    withTemplate: "")
        return Double(result)
    }
}
