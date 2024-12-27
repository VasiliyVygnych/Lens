//
//  String.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 26.11.2024.
//

import Foundation

extension String {
    func localized(_ language: String) -> String {
        if let path = Bundle.main.path(forResource: language,
                                       ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self,
                                     bundle: bundle,
                                     comment: "")
        }
        return ""
    }
}
