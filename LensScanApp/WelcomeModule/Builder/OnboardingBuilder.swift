//
//  OnboardingBuilder.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit

class OnboardingBuilder: OnboardingBuilderProtocol {

    func createWelcomeViewController(coordinator: OnboardingCoordinatorProtocol) -> UIViewController {
        let controller = WelcomeViewController()
        var viewModel: OnboardingViewModelProtocol = OnboardingViewModel()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        viewModel.coreData = coreData
        controller.viewModel = viewModel
        return controller
    }
    func createOnboardindView(coordinator: OnboardingCoordinatorProtocol) -> UIViewController {
        let controller = OnboardindViewController()
        var viewModel: OnboardingViewModelProtocol = OnboardingViewModel()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        viewModel.coreData = coreData
        viewModel.coordinator = coordinator
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        return controller
    }
    func createWebViewController(coordinator: OnboardingCoordinatorProtocol,
                                 mode: SettingsWebView) -> UIViewController {
        let controller = WebViewController()
        var viewModel: OnboardingViewModelProtocol = OnboardingViewModel()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        controller.mode = mode
        return controller
    }
    func createPayWallController(coordinator: OnboardingCoordinatorProtocol) -> UIViewController {
        let controller = PayWallController()
        var viewModel: OnboardingViewModelProtocol = OnboardingViewModel()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        return controller
    }
    func createTabBarController(coordinator: OnboardingCoordinatorProtocol) -> UIViewController {
        let controller = TabBarController()
        return controller
    }
}
