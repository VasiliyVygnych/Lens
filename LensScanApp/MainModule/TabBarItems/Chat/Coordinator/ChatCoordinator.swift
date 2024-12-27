//
//  ChatCoordinator.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

class ChatCoordinator: ChatCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: ChatBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: ChatBuilderProtocol = ChatBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    func createScanController(searchType: SearchType,
                              delegate: CropPhotoDelegate?) {
        if let navigationController = navigationController {
            let controller = assembler.createScanController(navigationController: navigationController,
                                                            searchType: searchType,
                                                            delegate: delegate)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
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
}
