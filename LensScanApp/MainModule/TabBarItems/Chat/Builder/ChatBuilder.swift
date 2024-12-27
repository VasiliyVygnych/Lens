//
//  ChatBuilder.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

class ChatBuilder: ChatBuilderProtocol {
    
    func createCropController(navigationController: UINavigationController,
                              delegate: CropPhotoDelegate?,
                              photo: UIImage?) -> UIViewController {
        let controller = CropController()
        var viewModel: ScanViewModelProtocol = ScanViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: ScanCoordinatorProtocol = ScanCoordinator(navigationController: navigationController)
        viewModel.coordinator = coordinator
        viewModel.network = network
        viewModel.subscription = subscription
        viewModel.coreData = coreData
        controller.viewModel = viewModel
        controller.delegate = delegate
        controller.photo = photo
        return controller
    }
    
    
    
    
    
    func createScanController(navigationController: UINavigationController,
                              searchType: SearchType,
                              delegate: CropPhotoDelegate?) -> UIViewController {
        let controller = ScanViewController()
        var viewModel: ScanViewModelProtocol = ScanViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        let coordinator: ScanCoordinatorProtocol = ScanCoordinator(navigationController: navigationController)
        viewModel.coordinator = coordinator
        viewModel.network = network
        viewModel.coreData = coreData
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        controller.searchType = searchType
        controller.imageDelegate = delegate
        return controller
    }
    
}
