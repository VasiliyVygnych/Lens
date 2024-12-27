//
//  Protocol.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 25.11.2024.
//

import UIKit

protocol NetworkManagerProtocol {

    func makeRequest(image: UIImage) async -> SearchResult?
    func sendMessage(data: ChatData) async throws -> chatResponse
}
