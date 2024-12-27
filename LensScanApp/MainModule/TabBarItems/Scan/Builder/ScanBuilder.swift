//
//  ScanBuilder.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

class ScanBuilder: ScanBuilderProtocol {
    
    
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
    func createResultScanController(coordinator: ScanCoordinatorProtocol,
                                    photo: UIImage?,
                                    model: SearchResult?) -> UIViewController {
        let controller = ResultScanController()
        var viewModel: ScanViewModelProtocol = ScanViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        viewModel.coordinator = coordinator
        viewModel.network = network
        viewModel.coreData = coreData
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        controller.preview = photo
        controller.model = model
        return controller
    }
    func createDetailScanController(coordinator: ScanCoordinatorProtocol,
                                    model: SearchResult?,
                                    photo: UIImage?) -> UIViewController {
        let controller = DetailScanController()
        var viewModel: ScanViewModelProtocol = ScanViewModel()
        let network: NetworkManagerProtocol = NetworkManager()
        let coreData: CoreManagerProtocol = CoreDataManager()
        let subscription: SubscriptionManagerProtocol = SubscriptionManager()
        viewModel.coordinator = coordinator
        viewModel.coreData = coreData
        viewModel.network = network
        viewModel.subscription = subscription
        controller.viewModel = viewModel
        controller.preview = photo
        controller.model = model
        return controller
    }
}
