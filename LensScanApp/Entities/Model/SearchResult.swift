//
//  SearchResult.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 25.11.2024.
//

import UIKit

struct SearchResult: Codable {
    let gptResult: GPTResult
    let itemResult: [ItemResult]

    enum CodingKeys: String, CodingKey {
        case gptResult = "gpt_result"
        case itemResult = "item_result"
    }
}
struct GPTResult: Codable {
    let title: String
    let label, facts: [String]
    let didYouKnow, price, description: String
    let specifications: [String]
    let performance, origin, weight, scientificName: String
    let interestingFacts: [InterestingFact?]?
    let interior, exterior: String
}
struct InterestingFact: Codable {
    let heading, text: String
}
struct ItemResult: Codable {
    let title, source: String
    let link: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title, source, link
        case imageURL = "imageUrl"
    }
}
