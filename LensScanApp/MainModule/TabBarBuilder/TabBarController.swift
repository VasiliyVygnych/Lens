//
//  TabBarController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {
    
    private var upView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "tabBarColor")
        return view
    }()
    private var imageScanButton: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "scanItems")
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.addSubview(upView)
        tabBar.addSubview(imageScanButton)
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor(named: "grayColorView")
        viewControllers = [createHomeController(),
                           createScanController(),
                           chatScanController()]
        tabBar.backgroundColor = UIColor(named: "tabBarColor")
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "tabBarColor")
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        imageScanButton.snp.makeConstraints { make in
            make.width.height.equalTo(62)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tabBar.snp.top).offset(12)
        }
        upView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(2)
            make.centerY.equalTo(tabBar.snp.top)
        }
    }
    func createHomeController() -> UIViewController {
        let controller = HomeViewController()
        let navigation = UINavigationController(rootViewController: controller)
        let coreData: CoreManagerProtocol = CoreDataManager()
        var viewModel: HomeViewModelProtocol = HomeViewModel()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: HomeCoordinatorProtocol = HomeCoordinator(navigationController: navigation)
        viewModel.coordinator = coordinator
        viewModel.coreData = coreData
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        controller.tabBarItem = UITabBarItem(title: "Home".localized(LanguageApp.appLaunguage),
                                             image: UIImage(named: "homeItems"),
                                             tag: 0)
        return navigation
    }
    func createScanController() -> UIViewController {
        let controller = ScanViewController()
        let navigation = UINavigationController(rootViewController: controller)
        var viewModel: ScanViewModelProtocol = ScanViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let coordinator: ScanCoordinatorProtocol = ScanCoordinator(navigationController: navigation)
        viewModel.coordinator = coordinator
        viewModel.network = network
        viewModel.subscription = subscription
        viewModel.coreData = coreData
        controller.viewModel = viewModel
        controller.tabBarItem = UITabBarItem(title: "",
                                             image: UIImage(),
                                             tag: 1)
        return navigation
    }
    func chatScanController() -> UIViewController {
        let controller = ChatViewController()
        let navigation = UINavigationController(rootViewController: controller)
        var viewModel: ChatViewModelProtocol = ChatViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let coordinator: ChatCoordinatorProtocol = ChatCoordinator(navigationController: navigation)
        viewModel.coordinator = coordinator
        viewModel.network = network
        viewModel.subscription = subscription
        viewModel.coreData = coreData
        controller.viewModel = viewModel
        controller.tabBarItem = UITabBarItem(title: "Chat AI".localized(LanguageApp.appLaunguage),
                                             image: UIImage(named: "chatItems"),
                                             tag: 2)
        return navigation
    }
}
