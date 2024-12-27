//
//  HomeProtocols.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit

protocol HistoryCellDelegate: AnyObject {
    func reloadData()
}

protocol HomeViewModelProtocol {
    
    var coordinator: HomeCoordinatorProtocol? { get set }
    var subscription: SubscriptionManagerProtocol? { get set }
    var coreData: CoreManagerProtocol? { get set }
    
//MARK: - Coordinator
    
    func openPayWallController()
    func openScanController(searchType: SearchType)
    func openChatController()
    func openSettingsViewController()
    func openHistoryViewController()
    func openFavoriteViewController()
    func openWebViewController(mode: SettingsWebView)
    func openDetailScanController(searchData: SearchData?,
                                  factsData: [FactsData]?)
    
//MARK: - CoreData
    
    func removeSearchData(id: Int)
    func removeSearchData()
    func getSearchData(_ sort: Bool) -> [SearchData]?
    func setSearchData(chatData: SearchSave)
    func editFavorite(_ value: Bool,
                      id: Int16?)
    func fetchFavorite(with bool: Bool) -> [SearchData]?
    
    func removeFactsData(id: Int)
    func removeFactsData()
    func getFactsData(_ sort: Bool) -> [FactsData]?
    func setFactsData(title: String,
                      description: String)
    func fetchFacts(with id: Int) -> [FactsData]?
    
    
//MARK: - Subscription
    
    func restoreSubscription()
    
//MARK: - UI
    
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double)
}

protocol HomeBuilderProtocol {
    func createPayWallController(navigationController: UINavigationController) -> UIViewController
    func createScanController(navigationController: UINavigationController,
                              searchType: SearchType) -> UIViewController
    func createChatController(navigationController: UINavigationController) -> UIViewController
    func createSettingsViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController
    func createHistoryViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController
    func createFavoriteViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController
    
    func createWebViewController(navigationController: UINavigationController,
                                 mode: SettingsWebView) -> UIViewController
    func createDetailScanController(navigationController: UINavigationController,
                                    searchData: SearchData?,
                                    factsData: [FactsData]?) -> UIViewController
}

protocol HomeCoordinatorProtocol {
    func createPayWallController()
    func createScanController(searchType: SearchType)
    func createChatController()
    func createSettingsViewController()
    func createHistoryViewController()
    func createFavoriteViewController()
    
    func createWebViewController(mode: SettingsWebView)
    func createDetailScanController(searchData: SearchData?,
                                    factsData: [FactsData]?)
}
