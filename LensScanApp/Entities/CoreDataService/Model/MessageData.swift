//
//  MessageData.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 27.11.2024.
//

import Foundation
import CoreData

@objc(MessageData)
public class MessageData: NSManagedObject {}
extension MessageData {
    @NSManaged public var id: Int16
    @NSManaged public var text: String?
    @NSManaged public var type: String?
    @NSManaged public var timestamp: Date
    @NSManaged public var image: Data
    @NSManaged public var chatAI: Bool
    @NSManaged public var like: Bool
    @NSManaged public var dislike: Bool
}
extension MessageData : Identifiable {}
