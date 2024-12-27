//
//  Settrings.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit

enum SettingsType {
    case restore
    case help
    case share
    case rate
    case suggest
    case privacy
    case terms
}


struct SettingsSection {
    let name: String
    let data: [SettingsData]
}
struct SettingsData {
    let title: String?
    let image: UIImage?
    let type: SettingsType
}
let generalData: [SettingsData] = [
    .init(title: "Restore Membership".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "restoreCell"),
          type: .restore),
    .init(title: "Help".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "helpCell"),
          type: .help)
    ]
let socialData: [SettingsData] = [
    .init(title: "Share".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "shareCell"),
          type: .share),
    .init(title: "Rate Us".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "rateCell"),
          type: .rate),
    .init(title: "Suggest Idea".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "suggestCell"),
          type: .suggest),
]
let legalData: [SettingsData] = [
    .init(title: "Privacy Policy".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "privacyCell"),
          type: .privacy),
    .init(title: "Terms of Use".localized(LanguageApp.appLaunguage),
          image: UIImage(named: "termCell"),
          type: .terms)
]
let settingsData: [SettingsSection] = [
        .init(name: "GENERAL".localized(LanguageApp.appLaunguage),
              data: generalData),
        .init(name: "SOCIAL".localized(LanguageApp.appLaunguage),
              data: socialData),
        .init(name: "LEGAL".localized(LanguageApp.appLaunguage),
              data: legalData)
    ]
