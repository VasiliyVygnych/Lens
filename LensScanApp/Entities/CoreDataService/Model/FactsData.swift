//
//  FactsData.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 03.12.2024.
//

import Foundation
import CoreData

@objc(FactsData)
public class FactsData: NSManagedObject {}
extension FactsData {
    @NSManaged public var id: Int16
    @NSManaged public var header: String?
    @NSManaged public var title: String?
}
extension FactsData : Identifiable {}

struct FactsModelSection {
    let title: String
    let items: [String]
    var isExpanded: Bool
}
