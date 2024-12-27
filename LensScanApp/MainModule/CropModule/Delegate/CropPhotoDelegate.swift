//
//  EditPhotoDelegate.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 22.11.2024.
//

import UIKit

protocol CropPhotoDelegate: AnyObject {
    func didSelectPhoto(_ photo: UIImage?)
}
