//
//  CoreManagerProtocol.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 27.11.2024.
//

import UIKit

protocol CoreManagerProtocol {
    func removeAll()
    
//MARK: - AppData
    func setAppModel(isLogin: Bool,
                     isSubscirbe: Bool)
    func getAppData() -> [AppData]
    func removeAppData()
    
//MARK: - MessageData
    func removeMessageData()
    func getMessageData(_ sort: Bool) -> [MessageData]
    func setMessageData(chatData: ChatData)
    func editLike(_ value: Bool,
                  id: Int16?)
    func editDislike(_ value: Bool,
                     id: Int16?)
    func removeLastMessage()
    
//MARK: - SearchData
    func removeSearchData(id: Int)
    func removeSearchData()
    func getSearchData(_ sort: Bool) -> [SearchData]
    func setSearchData(chatData: SearchSave)
    func editFavorite(_ value: Bool,
                      id: Int16?)
    func fetchFavorite(with bool: Bool) -> [SearchData]
    
//MARK: - FactsData
    func removeFactsData(id: Int)
    func removeFactsData()
    func getFactsData(_ sort: Bool) -> [FactsData]
    func setFactsData(title: String,
                      description: String)
    func fetchFacts(with id: Int) -> [FactsData]
}
