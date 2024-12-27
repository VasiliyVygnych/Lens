//
//  NetworkManager.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 25.11.2024.
//

import UIKit

final class NetworkManager: NetworkManagerProtocol {

    private var scanURL = "https://vaslente.fun/api/v4/getInfo"
    private let chatURL = "https://vaslente.fun/api/myChat/v1"

    func sendMessage(data: ChatData) async throws -> chatResponse {
        let language = LanguageApp.appLaunguage
        guard let url = URL(string: chatURL) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        var body: [String: Any] = [:]
        if data.tupe == "text" {
            let text: [String: Any] = [
                "lang": language,
                "prompt": "Ты мой личный помощник",
                "messages": [
                    [
                        "role": data.role,
                        "parts": [
                            [
                                "text": data.text
                            ]
                        ]
                    ]
                ]
            ]
            body = text
        }
        if data.tupe == "image" {
            let image: [String: Any] = [
                "lang": "ru",
                "prompt": "Ты мой личный помощник",
                "messages": [
                    [
                        "role": data.role,
                        "parts": [
                            [
                                "text": data.text
                            ],
                            [
                                "inline_data": [
                                    "mime_type": "image/jpeg",
                                    "data": data.imageStr
                                ]
                            ]
                        ]
                    ]
                ]
            ]
            body = image
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body,
                                                      options: [])
            request.httpBody = jsonData
        } catch {
            print("Ошибка при кодировании JSON: \(error)")
            throw URLError(.badServerResponse)
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let responseData = try JSONDecoder().decode(chatResponse.self,
                                                    from: data)
        return responseData
    }
    
    func makeRequest(image: UIImage) async -> SearchResult? {
        let language = LanguageApp.appLaunguage
        var multipart = MultipartRequestData()
        if let dataFrontImage = image.jpegData(compressionQuality: 0.9) {
            multipart.add(
                key: "image",
                fileName: "image.png",
                fileMimeType: "image/png",
                fileData: dataFrontImage
            )
        }
        multipart.add(key: "language",
                      value: language)
        guard let url = URL(string: scanURL) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeadeValue,
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let _ = String(data: data,
                                       encoding: String.Encoding.utf8) {
            }
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(SearchResult.self,
                                                 from: data)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
 }
 public extension Data {
    mutating func append(
        _ string: String,
        encoding: String.Encoding = .utf8) {
        guard let data = string.data(using: encoding) else {
            return
        }
        append(data)
    }
 }
 public struct MultipartRequestData {
    public let boundary: String
    private let separator: String = "\r\n"
    private var data: Data
    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    private mutating func appendSeparator() {
        data.append(separator)
    }
    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }
    public mutating func add(
        key: String,
        value: String
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }
    public mutating func add(
        key: String,
        fileName: String,
        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }
    public var httpContentTypeHeadeValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }
    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}
