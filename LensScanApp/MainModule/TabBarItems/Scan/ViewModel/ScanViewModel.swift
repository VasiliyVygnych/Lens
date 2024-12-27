//
//  ScanViewModel.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

class ScanViewModel: ScanViewModelProtocol {
    
    var coordinator: ScanCoordinatorProtocol?
    var subscription: SubscriptionManagerProtocol?
    var network: NetworkManagerProtocol?
    var coreData: CoreManagerProtocol? 
    weak var mainDelegate: ScnanMainViewDelegate?
    var task: Task<Void, Never>?
    

    func openCropController(delegate: CropPhotoDelegate?,
                            photo: UIImage?) {
        coordinator?.createCropController(delegate: delegate,
                                          photo: photo)
    }
    func openResultScanController(photo: UIImage?,
                                  model: SearchResult?)  {
        coordinator?.createResultScanController(photo: photo,
                                                model: model)
    }
    func openDetailScanController(model: SearchResult?,
                                  photo: UIImage?) {
        coordinator?.createDetailScanController(model: model,
                                                photo: photo)
    }
    
    
    
    
//MARK: - View
    
    func showAlert(title: String,
                   message: String,
                   actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        return alert
    }
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
    
//MARK: - Network
    
    func getSearchResults(_ image: UIImage) {
        task = Task {
            if let data = await network?.makeRequest(image: image) {
                DispatchQueue.main.async { [weak self] in
                    self?.mainDelegate?.successfulSearchResult(data)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.mainDelegate?.unsuccessfulSearchResult()
                }
                print("Error")
            }
        }
    }
    func cancelTask() {
        task?.cancel()
    }
    
    
//MARK: - CoreData

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
    
    
    
    
}
