//
//  ChatProtocols.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

protocol ChatViewDelegate: AnyObject {
    func chatResponse(_ text: String?)
    func errorSendImage()
}

protocol ChatViewModelProtocol {
    
    var coordinator: ChatCoordinatorProtocol? { get set }
    var subscription: SubscriptionManagerProtocol? { get set }
    var network: NetworkManagerProtocol? { get set }
    var delegate: ChatViewDelegate? { get set }
    var coreData: CoreManagerProtocol? { get set }
    
//MARK: - CoreData
    
    func removeMessageData()
    func getMessageData(_ sort: Bool) -> [MessageData]?
    func setMessageData(chatData: ChatData)
    func editLike(_ value: Bool,
                  id: Int16?)
    func editDislike(_ value: Bool,
                     id: Int16?)
    func removeLastMessage()
    
//MARK: - Coordinator
    func openScanController(searchType: SearchType,
                            delegate: CropPhotoDelegate?)
    func openCropController(delegate: CropPhotoDelegate?,
                            photo: UIImage?)
    
//MARK: - View
    
    func viewAnimate(view: UIView,
                     duration: Double,
                     scale: Double)
    
//MARK: - Network
    
    func sendMessage(data: ChatData)
}

protocol ChatBuilderProtocol {
    
    func createScanController(navigationController: UINavigationController,
                              searchType: SearchType,
                              delegate: CropPhotoDelegate?) -> UIViewController
    func createCropController(navigationController: UINavigationController,
                              delegate: CropPhotoDelegate?,
                              photo: UIImage?) -> UIViewController
}


protocol ChatCoordinatorProtocol {
    func createScanController(searchType: SearchType,
                              delegate: CropPhotoDelegate?)
    
    func createCropController(delegate: CropPhotoDelegate?,
                              photo: UIImage?)
    
}
