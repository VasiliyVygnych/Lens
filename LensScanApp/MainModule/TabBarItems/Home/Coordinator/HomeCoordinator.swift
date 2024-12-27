//
//  HomeCoordinator.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import Foundation
import UIKit

class HomeCoordinator: HomeCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: HomeBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: HomeBuilderProtocol = HomeBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
  
    func createPayWallController() {
        if let navigationController = navigationController {
            let controller = assembler.createPayWallController(navigationController: navigationController)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createScanController(searchType: SearchType) {
        if let navigationController = navigationController {
            let controller = assembler.createScanController(navigationController: navigationController,
                                                            searchType: searchType)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createChatController() {
        if let navigationController = navigationController {
            let controller = assembler.createChatController(navigationController: navigationController)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createSettingsViewController() {
        if let navigationController = navigationController {
            let controller = assembler.createSettingsViewController(coordinator: self)
            navigationController.pushViewController(controller,
                                                    animated: true)
        }
    }
    func createHistoryViewController() {
        if let navigationController = navigationController {
            let controller = assembler.createHistoryViewController(coordinator: self)
            navigationController.pushViewController(controller,
                                                    animated: true)
        }
    }
    func createFavoriteViewController() {
        if let navigationController = navigationController {
            let controller = assembler.createFavoriteViewController(coordinator: self)
            navigationController.pushViewController(controller,
                                                    animated: true)
        }
    }
    
    
    
    
    func createWebViewController(mode: SettingsWebView) {
        if let navigationController = navigationController {
            let controller = assembler.createWebViewController(navigationController: navigationController,
                                                               mode: mode)
            navigationController.pushViewController(controller,
                                                    animated: true)
        }
    }
    func createDetailScanController(searchData: SearchData?,
                                    factsData: [FactsData]?) {
        if let navigationController = navigationController {
            let controller = assembler.createDetailScanController(navigationController: navigationController,
                                                                  searchData: searchData,
                                                                  factsData: factsData)
            navigationController.pushViewController(controller,
                                                    animated: true)
        }
    }
}
