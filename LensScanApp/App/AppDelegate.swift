// pglee899adriankwoe@gmail.com
// Serdinho321.
// com.lensscan.rodora

//  AppDelegate.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder,
                    UIApplicationDelegate {



    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
//MARK: - Core Data
        lazy var persistentContainer: NSPersistentContainer = {
           let conteiner = NSPersistentContainer(name: "Model")
            conteiner.loadPersistentStores { (description,
                                              error) in
                if let error {
                    print(error.localizedDescription)
                }
            }
            return conteiner
        }()
        func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolver error \(error), \(nsError.userInfo)")
                }
            }
        }
    
    }

