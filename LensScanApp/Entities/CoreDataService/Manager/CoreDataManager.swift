//
//  CoreDataManager.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 27.11.2024.
//

import UIKit
import CoreData

final class CoreDataManager: CoreManagerProtocol {
    
    var delegat: AppDelegate
    var context: NSManagedObjectContext
    
    init() {
        delegat = UIApplication.shared.delegate as! AppDelegate
        context = delegat.persistentContainer.viewContext
    }
    
    func removeAll() {
        removeAppData()
        removeMessageData()
        removeSearchData()
        removeFactsData()
    }
}
//MARK: - AppData
extension CoreDataManager {
    func removeAppData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
            let data = try? context.fetch(fetchRequest) as? [AppData]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func getAppData() -> [AppData] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AppData")
        do {
            return try context.fetch(fetchRequest) as! [AppData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func setAppModel(isLogin: Bool,
                     isSubscirbe: Bool) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "AppData",
                                                         in: context) else { return }
        let date = AppData(entity: nameEntity,
                             insertInto: context)
        date.id = 0
        date.isLogin = isLogin
        date.dateSubscirbe = Date()
        date.isSubscirbe = isSubscirbe
        delegat.saveContext()
    }
}

//MARK: - MessageData
extension CoreDataManager {
    func removeMessageData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageData")
        do {
            let data = try? context.fetch(fetchRequest) as? [MessageData]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func removeLastMessage() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageData")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [MessageData],
                  let mark = data.last else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    
    
    
    
    func getMessageData(_ sort: Bool) -> [MessageData] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageData")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [MessageData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func setMessageData(chatData: ChatData) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "MessageData",
                                                         in: context) else { return }
        let model = MessageData(entity: nameEntity,
                                insertInto: context)
        let data = getMessageData(true)
        model.id = Int16(data.count - 1)
        model.text = chatData.text
        model.dislike = false
        model.like = false
        model.type = chatData.tupe
        model.image = chatData.image?.pngData() ?? Data()
        
        model.chatAI = chatData.chatAI
        model.timestamp = Date()
        delegat.saveContext()
    }
    func editLike(_ value: Bool,
                  id: Int16?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [MessageData],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.like = value
        }
        delegat.saveContext()
    }
    func editDislike(_ value: Bool,
                     id: Int16?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [MessageData],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.dislike = value
        }
        delegat.saveContext()
    }
    
}

//MARK: - SearchData
extension CoreDataManager {
    func removeSearchData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchData")
        do {
            let data = try? context.fetch(fetchRequest) as? [SearchData]
            data?.forEach({ context.delete($0) })
            removeFactsData()
        }
        delegat.saveContext()
    }
    func removeSearchData(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MessageData")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [MessageData],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
            removeFactsData(id: Int(mark.id))
        }
        delegat.saveContext()
    }
    
    func getSearchData(_ sort: Bool) -> [SearchData] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchData")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [SearchData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func setSearchData(chatData: SearchSave) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "SearchData",
                                                         in: context) else { return }
        let model = SearchData(entity: nameEntity,
                               insertInto: context)
        let data = getSearchData(true)
        model.id = Int16(data.count - 1)
        model.preview = chatData.image?.pngData() ?? Data()
        model.title = chatData.title ?? ""
        model.titleDescription = chatData.description ?? ""
        model.origin = chatData.origin ?? ""
        model.weight = chatData.weight ?? ""
        model.scientificName = chatData.scientificName ?? ""
        model.youNow = chatData.youNow ?? ""
        model.price = chatData.price ?? ""
        model.rating = chatData.rating ?? ""
        model.isVavorite = chatData.isVavorite
        model.dateOfCreate = Date()
        delegat.saveContext()
    }
    func editFavorite(_ value: Bool,
                      id: Int16?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchData")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [SearchData],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.isVavorite = value
        }
        delegat.saveContext()
    }
    func fetchFavorite(with bool: Bool) -> [SearchData] {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchData")
        fetchRequest.predicate = NSPredicate(format: "isVavorite == %@",
                                             NSNumber(value: bool))
        do {
            return try context.fetch(fetchRequest) as! [SearchData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}

//MARK: - FactsData
extension CoreDataManager {
    func removeFactsData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FactsData")
        do {
            let data = try? context.fetch(fetchRequest) as? [FactsData]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    func removeFactsData(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FactsData")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [FactsData],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    
    func getFactsData(_ sort: Bool) -> [FactsData] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FactsData")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [FactsData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func setFactsData(title: String,
                      description: String) {
       guard let nameEntity = NSEntityDescription.entity(forEntityName: "FactsData",
                                                         in: context) else { return }
        let model = FactsData(entity: nameEntity,
                               insertInto: context)
        let data = getSearchData(true)
        model.id = Int16(data.count)
        model.title = description
        model.header = title
        delegat.saveContext()
    }
    func fetchFacts(with id: Int) -> [FactsData] {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FactsData")
        fetchRequest.predicate = NSPredicate(format: "id == %d",
                                             id)
        do {
            return try context.fetch(fetchRequest) as! [FactsData]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
