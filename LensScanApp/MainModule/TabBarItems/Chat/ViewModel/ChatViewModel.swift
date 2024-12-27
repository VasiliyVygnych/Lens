//
//  ChatViewModel.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

class ChatViewModel: ChatViewModelProtocol {
    
    var coordinator: ChatCoordinatorProtocol?
    var subscription: SubscriptionManagerProtocol?
    var network: NetworkManagerProtocol?
    var coreData: CoreManagerProtocol?
    var task: Task<Void, Never>?
    weak var delegate: ChatViewDelegate?
    
//MARK: - CoreData
    
    func removeMessageData() {
        coreData?.removeMessageData()
    }
    func getMessageData(_ sort: Bool) -> [MessageData]? {
        return coreData?.getMessageData(sort)
    }
    func setMessageData(chatData: ChatData) {
        coreData?.setMessageData(chatData: chatData)
    }
    func editLike(_ value: Bool,
                  id: Int16?) {
        coreData?.editLike(value,
                           id: id)
    }
    func editDislike(_ value: Bool,
                     id: Int16?) {
        coreData?.editDislike(value,
                              id: id)
    }
    func removeLastMessage() {
        coreData?.removeLastMessage()
    }
    
//MARK: - Coordinator
   
    func openScanController(searchType: SearchType,
                            delegate: CropPhotoDelegate?) {
        coordinator?.createScanController(searchType: searchType,
                                          delegate: delegate)
    }
    func openCropController(delegate: CropPhotoDelegate?,
                            photo: UIImage?) {
        coordinator?.createCropController(delegate: delegate,
                                          photo: photo)
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
    
//MARK: - Network
    
    func sendMessage(data: ChatData) {
        task = Task {
            do {
                let data = try await network?.sendMessage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.chatResponse(data?.text)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.errorSendImage()
                }
            }
        }
    }
}
