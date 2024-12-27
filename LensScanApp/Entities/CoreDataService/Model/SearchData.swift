//
//  SearchData.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 03.12.2024.
//

import UIKit
import CoreData

@objc(SearchData)
public class SearchData: NSManagedObject {}
extension SearchData {
    @NSManaged public var id: Int16
    @NSManaged public var preview: Data
    @NSManaged public var dateOfCreate: Date
    
    @NSManaged public var title: String
    @NSManaged public var titleDescription: String
    
    @NSManaged public var origin: String
    @NSManaged public var weight: String
    @NSManaged public var scientificName: String
    @NSManaged public var youNow: String
    @NSManaged public var price: String
    @NSManaged public var rating: String
    
    @NSManaged public var isVavorite: Bool
}
extension SearchData : Identifiable {}

struct SearchSave {
    let image: UIImage?
    let title: String?
    let description: String?
    let origin: String?
    let weight: String?
    let scientificName: String?
    let youNow: String?
    let price: String?
    let rating: String?
    let isVavorite: Bool
}
