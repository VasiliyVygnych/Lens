//
//  OnboardingProtocol.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit


protocol OnboardingViewModelProtocol {
    
    var coordinator: OnboardingCoordinatorProtocol? { get set }
    var subscription: SubscriptionManagerProtocol? { get set }
    var coreData: CoreManagerProtocol? { get set }

//MARK: - Coordinator
    
    func openOnboardindView()
    func openPayWallController()
    func openTabBar(botton: UIButton)
    func openWebViewController(mode: SettingsWebView)
    func openTabBar()
    
//MARK: - CoreData
    
    func setAppModel(isLogin: Bool,
                     isSubscirbe: Bool)
    func getAppData() -> [AppData]?
    func removeAppData()
    
//MARK: - UI
    
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double)
    
//MARK: - Subscription
    
    func delegate(_ delegate: SubscriptionDelegate)
    func subscribe(to subscription: Subscription)
    func loadProducts()
    func restoreSubscription()
    func removeLetters(from input: String) -> Double?
}

protocol OnboardingBuilderProtocol {
    func createWelcomeViewController(coordinator: OnboardingCoordinatorProtocol) -> UIViewController
    func createOnboardindView(coordinator: OnboardingCoordinatorProtocol) -> UIViewController
    func createTabBarController(coordinator: OnboardingCoordinatorProtocol) -> UIViewController
    func createWebViewController(coordinator: OnboardingCoordinatorProtocol,
                                 mode: SettingsWebView) -> UIViewController
    func createPayWallController(coordinator: OnboardingCoordinatorProtocol) -> UIViewController
}

protocol OnboardingCoordinatorProtocol {
    func initial()
    func createOnboardindView()
    func initialTabBar()
    func createWebViewController(mode: SettingsWebView)
    func createPayWallController()
}
