//
//  ScanProtocols.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

protocol ScnanMainViewDelegate: AnyObject {
    func successfulSearchResult(_ model: SearchResult)
    func unsuccessfulSearchResult()
}

protocol ScanViewModelProtocol {
    
    var coordinator: ScanCoordinatorProtocol? { get set }
    var subscription: SubscriptionManagerProtocol? { get set }
    var network: NetworkManagerProtocol? { get set }
    var mainDelegate: ScnanMainViewDelegate? { get set }
    var coreData: CoreManagerProtocol? { get set }
    
//MARK: - Coordinator
    
    func openCropController(delegate: CropPhotoDelegate?,
                            photo: UIImage?)
    func openResultScanController(photo: UIImage?,
                                  model: SearchResult?)
    func openDetailScanController(model: SearchResult?,
                                  photo: UIImage?)
    
//MARK: - View
    
    func showAlert(title: String,
                   message: String,
                   actions: [UIAlertAction]) -> UIAlertController
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double)
    
//MARK: - Network
    
    func getSearchResults(_ image: UIImage)
    func cancelTask()
    
    
//MARK: - CoreData
    func removeSearchData(id: Int)
    func removeSearchData()
    func getSearchData(_ sort: Bool) -> [SearchData]?
    func setSearchData(chatData: SearchSave)
    func editFavorite(_ value: Bool,
                      id: Int16?)
    
    func removeFactsData(id: Int)
    func removeFactsData()
    func getFactsData(_ sort: Bool) -> [FactsData]?
    func setFactsData(title: String,
                      description: String)
    
}

protocol ScanBuilderProtocol {
    func createCropController(navigationController: UINavigationController,
                              delegate: CropPhotoDelegate?,
                              photo: UIImage?) -> UIViewController
    func createResultScanController(coordinator: ScanCoordinatorProtocol,
                                   photo: UIImage?,
                                    model: SearchResult?) -> UIViewController
    func createDetailScanController(coordinator: ScanCoordinatorProtocol,
                                    model: SearchResult?,
                                    photo: UIImage?) -> UIViewController
}

protocol ScanCoordinatorProtocol {
    func createCropController(delegate: CropPhotoDelegate?,
                              photo: UIImage?)
    func createResultScanController(photo: UIImage?,
                                    model: SearchResult?)
    func createDetailScanController(model: SearchResult?,
                                    photo: UIImage?)
}
