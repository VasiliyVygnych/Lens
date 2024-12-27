//
//  HomeViewModel.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit

class HomeViewModel: HomeViewModelProtocol {
    
    var coordinator: HomeCoordinatorProtocol?
    var subscription: SubscriptionManagerProtocol?
    var coreData: CoreManagerProtocol? 
    
// MARK: - Coordinator
    
    func openPayWallController() {
        coordinator?.createPayWallController()
    }
    func openScanController(searchType: SearchType) {
        coordinator?.createScanController(searchType: searchType)
    }
    func openChatController() {
        coordinator?.createChatController()
    }
    func openSettingsViewController() {
        coordinator?.createSettingsViewController()
    }
    func openHistoryViewController() {
        coordinator?.createHistoryViewController()
    }
    func openWebViewController(mode: SettingsWebView) {
        coordinator?.createWebViewController(mode: mode)
    }
    func openFavoriteViewController() {
        coordinator?.createFavoriteViewController()
    }
    func openDetailScanController(searchData: SearchData?,
                                  factsData: [FactsData]?) {
        coordinator?.createDetailScanController(searchData: searchData,
                                                factsData: factsData)
    }
    
// MARK: - CoreData
    
    func removeSearchData(id: Int) {
        coreData?.removeSearchData(id: id)
    }
    func removeSearchData() {
        coreData?.removeSearchData()
    }
    func getSearchData(_ sort: Bool) -> [SearchData]? {
        return coreData?.getSearchData(sort)
    }
    func setSearchData(chatData: SearchSave) {
        coreData?.setSearchData(chatData: chatData)
    }
    func editFavorite(_ value: Bool,
                      id: Int16?) {
        coreData?.editFavorite(value,
                               id: id)
    }
    func fetchFavorite(with bool: Bool) -> [SearchData]? {
        return coreData?.fetchFavorite(with: bool)
    }
    
    func removeFactsData(id: Int) {
        coreData?.removeFactsData(id: id)
    }
    func removeFactsData() {
        coreData?.removeFactsData()
    }
    func getFactsData(_ sort: Bool) -> [FactsData]? {
        return coreData?.getFactsData(sort)
    }
    func setFactsData(title: String,
                      description: String) {
        coreData?.setFactsData(title: title,
                               description: description)
    }
    func fetchFacts(with id: Int) -> [FactsData]? {
        return coreData?.fetchFacts(with: id)
    }
   

//MARK: - Subscription
    
    func restoreSubscription() {
        Task {
            try await subscription?.restorePurchases()
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
}
