//
//  AppData.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 27.11.2024.
//

import Foundation
import CoreData

@objc(AppData)
public class AppData: NSManagedObject {}
extension AppData {
    @NSManaged public var id: Int16
    @NSManaged public var dateSubscirbe: Date
    @NSManaged public var isSubscirbe: Bool
    @NSManaged public var isLogin: Bool
}
extension AppData : Identifiable {}
