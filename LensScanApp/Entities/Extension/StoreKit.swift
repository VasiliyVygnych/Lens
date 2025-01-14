//
//  StoreKit.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import StoreKit

extension SKStoreReviewController {
    public static func requestRateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
