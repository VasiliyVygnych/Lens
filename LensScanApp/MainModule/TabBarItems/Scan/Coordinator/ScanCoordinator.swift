//
//  ScanCoordinator.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import Foundation
import UIKit

class ScanCoordinator: ScanCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: ScanBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: ScanBuilderProtocol = ScanBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }

    func createCropController(delegate: CropPhotoDelegate?,
                              photo: UIImage?) {
        if let navigationController = navigationController {
            let controller = assembler.createCropController(navigationController: navigationController,
                                                            delegate: delegate,
                                                            photo: photo)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createResultScanController(photo: UIImage?,
                                    model: SearchResult?) {
        if let navigationController = navigationController {
            let controller = assembler.createResultScanController(coordinator: self,
                                                                  photo: photo,
                                                                  model: model)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    func createDetailScanController(model: SearchResult?,
                                    photo: UIImage?) {
        if let navigationController = navigationController {
            let controller = assembler.createDetailScanController(coordinator: self,
                                                                  model: model,
                                                                  photo: photo)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
    
    
    
    
}
