//
//  ViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    var viewModel: OnboardingViewModelProtocol?
    private let languages = ["en", "ru", "de", "es", "fr", "it"]
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var rateImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 24,
                                weight: .bold)
        view.textAlignment = .center
        return view
    }()
    private var headerSubtitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 2
        view.font = .systemFont(ofSize: 14,
                                weight: .light)
        view.textAlignment = .center
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        if let current = Locale.preferredLanguages.first {
            LanguageApp.appLaunguage = currentLetters(current)
        }
        setupUI()
        setupText()
        setupColor()
        setupImage()
        setupConstraints()
        
//        viewModel?.deleteAppData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if self?.viewModel?.getAppData()?.isEmpty == false {
                self?.viewModel?.openTabBar()
            } else {
                self?.viewModel?.openOnboardindView()
            }
        }
    }
    func currentLetters(_ from: String) -> String {
        let uppercaseLetters = CharacterSet.uppercaseLetters
        let nonAlphanumeric = CharacterSet.alphanumerics.inverted
        let filteredString = from.unicodeScalars.filter {
            !uppercaseLetters.contains($0) && !nonAlphanumeric.contains($0)
        }
        var result = String()
        if languages.contains(String(filteredString)) {
            result = String(filteredString)
        } else {
            result = "en"
        }
        return result
    }
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.addSubview(rateImage)
        view.addSubview(headerTitle)
        view.addSubview(headerSubtitle)
    }
    private func setupText() {
        headerTitle.text = "+1M items scanned".localized(LanguageApp.appLaunguage)
        headerSubtitle.text = "User choice worldwide".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .white
        headerTitle.textColor = .black
        headerSubtitle.textColor = UIColor(named: "grayCustomColor")
    }
    private func setupImage() {
        backgroundImage.image = UIImage(named: "backgroundImage")
        rateImage.image = UIImage(named: "rateImage")
    }
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        rateImage.snp.makeConstraints { make in
            make.width.equalTo(310)
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(50)
        }
        headerTitle.snp.makeConstraints { make in
            make.top.equalTo(rateImage.snp.top).inset(-5)
            make.left.equalTo(rateImage.snp.left).inset(25)
            make.right.equalTo(rateImage.snp.right).inset(25)
            make.height.lessThanOrEqualTo(40)
        }
        headerSubtitle.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(10)
            make.left.equalTo(rateImage.snp.left).inset(25)
            make.right.equalTo(rateImage.snp.right).inset(25)
            make.height.lessThanOrEqualTo(50)
        }
    }
}
