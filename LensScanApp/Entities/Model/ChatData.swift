//
//  ChatData.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 27.11.2024.
//


import UIKit

struct ChatData {
    let role: String
    let imageStr: String?
    let text: String
    let tupe: String
    
    let chatAI: Bool
    let image: UIImage?
}
struct chatResponse: Codable {
    let text: String
}
