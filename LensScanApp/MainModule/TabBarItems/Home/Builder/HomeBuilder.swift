//
//  HomeBuilder.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit

class HomeBuilder: HomeBuilderProtocol {
    
    func createPayWallController(navigationController: UINavigationController) -> UIViewController {
        let controller = PayWallController()
        var viewModel: OnboardingViewModelProtocol = OnboardingViewModel()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: OnboardingCoordinatorProtocol = OnboardingCoordinator(navigationController: navigationController)
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        return controller
    }
    
    func createScanController(navigationController: UINavigationController,
                              searchType: SearchType) -> UIViewController {
        let controller = ScanViewController()
        var viewModel: ScanViewModelProtocol = ScanViewModel()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let network: NetworkManagerProtocol = NetworkManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: ScanCoordinatorProtocol = ScanCoordinator(navigationController: navigationController)
        viewModel.coordinator = coordinator
        viewModel.network = network
        viewModel.coreData = coreData
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        controller.searchType = searchType
        return controller
    }
    func createChatController(navigationController: UINavigationController) -> UIViewController {
        let controller = ChatViewController()
        var viewModel: ChatViewModelProtocol = ChatViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: ChatCoordinatorProtocol = ChatCoordinator(navigationController: navigationController)
        viewModel.coordinator = coordinator
        viewModel.network = network
        viewModel.coreData = coreData
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        return controller
    }
    
    func createSettingsViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController {
        let controller = SettingsViewController()
        var viewModel: HomeViewModelProtocol = HomeViewModel()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        viewModel.coordinator = coordinator
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        return controller
    }
    func createHistoryViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController {
        let controller = HistoryViewController()
        let coreData: CoreManagerProtocol = CoreDataManager()
        var viewModel: HomeViewModelProtocol = HomeViewModel()
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        viewModel.coreData = coreData
        return controller
    }
    func createFavoriteViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController {
        let controller = FavoriteViewController()
        let coreData: CoreManagerProtocol = CoreDataManager()
        var viewModel: HomeViewModelProtocol = HomeViewModel()
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        viewModel.coreData = coreData
        return controller
    }
    
    func createWebViewController(navigationController: UINavigationController,
                                 mode: SettingsWebView) -> UIViewController {
        let controller = WebViewController()
        var viewModel: OnboardingViewModelProtocol = OnboardingViewModel()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: OnboardingCoordinatorProtocol = OnboardingCoordinator(navigationController: navigationController)
        viewModel.subscription = subscription
        viewModel.coordinator = coordinator
        controller.viewModel = viewModel
        controller.mode = mode
        return controller
    }
    func createDetailScanController(navigationController: UINavigationController,
                                    searchData: SearchData?,
                                    factsData: [FactsData]?) -> UIViewController {
        let controller = DetailScanController()
        var viewModel: ScanViewModelProtocol = ScanViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: ScanCoordinatorProtocol = ScanCoordinator(navigationController: navigationController)
        viewModel.coordinator = coordinator
        viewModel.coreData = coreData
        viewModel.network = network
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        controller.searchData = searchData
        controller.factsData = factsData
        return controller
    }
}
