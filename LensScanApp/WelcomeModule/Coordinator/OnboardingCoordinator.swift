//
//  OnboardingCoordinator.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit

class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: OnboardingBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: OnboardingBuilderProtocol = OnboardingBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
    func initial() {
        if let navigationController = navigationController {
            let controller = assembler.createWelcomeViewController(coordinator: self)
            navigationController.viewControllers = [controller]
        }
    }
    func createOnboardindView() {
        if let navigationController = navigationController {
            let controller = assembler.createOnboardindView(coordinator: self)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func initialTabBar() {
        if let navigationController = navigationController {
            let controller = assembler.createTabBarController(coordinator: self)
            navigationController.viewControllers = [controller]
        }
    }
    func createWebViewController(mode: SettingsWebView) {
        if let navigationController = navigationController {
            let controller = assembler.createWebViewController(coordinator: self,
                                                               mode: mode)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    
    
    
    
    
    func createPayWallController() {
        if let navigationController = navigationController {
            let controller = assembler.createPayWallController(coordinator: self)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
}
