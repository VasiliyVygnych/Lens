//
//  Popular.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit

enum SearchType {
    case pets
    case coin
    case plant
    case food
    case devices
    case interior
    case architecture
    case cars
    case seashells
    case paintings
    case anything
    case chatAI
}

struct PopularData {
    let id: Int
    let title: String?
    let subtitle: String?
    let image: UIImage?
    let type: SearchType
}

let popularModel: [PopularData] = [
    .init(id: 0,
          title: "Pets".localized(LanguageApp.appLaunguage),
          subtitle: "Uncover unknown facts about your best friend".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "petsImage"),
          type: .pets),
    .init(id: 1,
          title: "Coin".localized(LanguageApp.appLaunguage),
          subtitle: "Find out who the coin belongs to and its value".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "coinmage"),
          type: .coin),
    .init(id: 2,
          title: "Plant".localized(LanguageApp.appLaunguage),
          subtitle: "Identify plants and learn how to care for them".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "plantsImage"),
          type: .plant),
    .init(id: 3,
          title: "Food".localized(LanguageApp.appLaunguage),
          subtitle: "Discover the secrets behind your favorite dishes".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "foodImage"),
          type: .food),
    .init(id: 4,
          title: "Devices".localized(LanguageApp.appLaunguage),
          subtitle: "Unravel the mysteries of your tech gadgets".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "devicesImage"),
          type: .devices),
    .init(id: 5,
          title: "Interior".localized(LanguageApp.appLaunguage),
          subtitle: "Find inspiration for your dream home".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "interiorImage"),
          type: .interior),
    .init(id: 6,
          title: "Architecture".localized(LanguageApp.appLaunguage),
          subtitle: "Explore the world's most iconic buildings".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "architectureImage"),
          type: .architecture),
    .init(id: 7,
          title: "Cars".localized(LanguageApp.appLaunguage),
          subtitle: "Discover the history and specifications of your favorite cars".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "carsImage"),
          type: .cars),
    .init(id: 8,
          title: "Seashells".localized(LanguageApp.appLaunguage),
          subtitle: "Identify seashells and learn about marine life".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "seashellsImage"),
          type: .seashells),
    .init(id: 9,
          title: "Paintings".localized(LanguageApp.appLaunguage),
          subtitle: "Explore the masterpieces and their significance in the history of art".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "paintingsImage"),
          type: .paintings),
    ]
