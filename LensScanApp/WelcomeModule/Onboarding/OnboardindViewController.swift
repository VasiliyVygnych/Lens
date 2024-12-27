//
//  FirstOnboardindView.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import SnapKit
import StoreKit

class OnboardindViewController: UIViewController {
    
    var viewModel: OnboardingViewModelProtocol?
    var currentImageIndex = 0
    private let pageModel = ["page1", "page2", "page3", "page4", "page5"]
    private var imageModel: [String] = []
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 28,
                                weight: .bold)
        view.textAlignment = .center
        return view
    }()
    private var nextScreenButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 25
        view.titleLabel?.font = .systemFont(ofSize: 15,
                                            weight: .bold)
        return view
    }()
    
    private var closeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var restoreButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .systemFont(ofSize: 13,
                                            weight: .medium)
        view.titleLabel?.textAlignment = .right
        view.tag = 1
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.titleLabel?.minimumScaleFactor = 0.2
        return view
    }()
    private var termsButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .systemFont(ofSize: 13,
                                            weight: .medium)
        view.titleLabel?.textAlignment = .right
        view.tag = 2
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.titleLabel?.minimumScaleFactor = 0.2
        return view
    }()
    private var privacyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .systemFont(ofSize: 13,
                                            weight: .medium)
        view.titleLabel?.textAlignment = .right
        view.tag = 3
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.titleLabel?.minimumScaleFactor = 0.2
        return view
    }()
    private var secondHeaderTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 28,
                                weight: .bold)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var firstInfoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var firstInfoTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .regular)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    private var secondInfoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var secondInfoTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .regular)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    private var threeInfoImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var threeInfoTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .regular)
        view.textAlignment = .center
        return view
    }()
    private var priceTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 17,
                                weight: .medium)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var subscrideButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.titleLabel?.font = .systemFont(ofSize: 15,
                                            weight: .bold)
        return view
    }()
    private var pageControlImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        setupText()
        setupColor()
        setupImage()
        setupeButton()
        setupConstraints()
        viewModel?.loadProducts()
        viewModel?.delegate(self)
    }
    private func setupUI() {
        view.addSubview(backgroundImage)
        view.addSubview(headerTitle)
        view.addSubview(nextScreenButton)
        
        view.addSubview(closeButton)
        view.addSubview(restoreButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(secondHeaderTitle)
        view.addSubview(firstInfoTitle)
        view.addSubview(firstInfoImage)
        view.addSubview(secondInfoImage)
        view.addSubview(secondInfoTitle)
        view.addSubview(threeInfoImage)
        view.addSubview(threeInfoTitle)
        view.addSubview(priceTitle)
        view.addSubview(subscrideButton)
        
        view.addSubview(pageControlImage)
        
        setupLastView(false)
    }
    
     private func setupLastView(_ bool: Bool) {
         if bool {
             headerTitle.isHidden = true
             nextScreenButton.isHidden = true
             
             closeButton.isHidden = false
             restoreButton.isHidden = false
             termsButton.isHidden = false
             privacyButton.isHidden = false
             secondHeaderTitle.isHidden = false
             firstInfoTitle.isHidden = false
             firstInfoImage.isHidden = false
             secondInfoImage.isHidden = false
             secondInfoTitle.isHidden = false
             threeInfoImage.isHidden = false
             threeInfoTitle.isHidden = false
             priceTitle.isHidden = false
             subscrideButton.isHidden = false
         } else {
             headerTitle.isHidden = false
             nextScreenButton.isHidden = false
             
             closeButton.isHidden = true
             restoreButton.isHidden = true
             termsButton.isHidden = true
             privacyButton.isHidden = true
             secondHeaderTitle.isHidden = true
             firstInfoTitle.isHidden = true
             firstInfoImage.isHidden = true
             secondInfoImage.isHidden = true
             secondInfoTitle.isHidden = true
             threeInfoImage.isHidden = true
             threeInfoTitle.isHidden = true
             priceTitle.isHidden = true
             subscrideButton.isHidden = true
         }
    }

    private func setupText() {
        nextScreenButton.setTitle("Next".localized(LanguageApp.appLaunguage),
                      for: .normal)
        headerTitle.text = "Scan and explore".localized(LanguageApp.appLaunguage)
        
        subscrideButton.setTitle("Next".localized(LanguageApp.appLaunguage),
                                  for: .normal)
        
        restoreButton.setTitle("Restore".localized(LanguageApp.appLaunguage),
                               for: .normal)
        termsButton.setTitle("Terms".localized(LanguageApp.appLaunguage),
                             for: .normal)
        privacyButton.setTitle("Privacy".localized(LanguageApp.appLaunguage),
                               for: .normal)
        secondHeaderTitle.text = "Get Full Access to Lens Photo".localized(LanguageApp.appLaunguage)
        threeInfoTitle.text = "Your personal expert".localized(LanguageApp.appLaunguage)
        secondInfoTitle.text = "All the answers are at your fingertips".localized(LanguageApp.appLaunguage)
        firstInfoTitle.text = "Discover the world with a new perspective".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .white
        headerTitle.textColor = .white
        
        restoreButton.setTitleColor(.white,
                                    for: .normal)
        termsButton.setTitleColor(.white,
                                  for: .normal)
        privacyButton.setTitleColor(.white,
                                    for: .normal)
        secondHeaderTitle.textColor = .white
        subscrideButton.setTitleColor(.systemBlue,
                                       for: .normal)
        subscrideButton.backgroundColor = .white
        priceTitle.textColor = .white
        threeInfoTitle.textColor = .white
        secondInfoTitle.textColor = .white
        firstInfoTitle.textColor = .white
    }
    private func setupImage() {
        pageControlImage.image = UIImage(named: pageModel[currentImageIndex])
        languageOnboardin(LanguageApp.appLaunguage)
        nextScreenButton.setTitleColor(.systemBlue,
                           for: .normal)
        nextScreenButton.backgroundColor = .white
        
        closeButton.setBackgroundImage(UIImage(named: "closeButton"),
                                       for: .normal)
        threeInfoImage.image = UIImage(named: "threeInfoImage")
        secondInfoImage.image = UIImage(named: "secondInfoImageLoad")
        firstInfoImage.image = UIImage(named: "firstInfoImageLoad")
    }
    private func languageOnboardin(_ language: String)  {
        switch language {
        case "en":
            let imageEN = ["firstOnboardindEN", "secondOnboardindEN",
                           "thirdOnboardindEN", "fourthOnboardindEN", "fifthOnboardindEN"]
            imageModel.append(contentsOf: imageEN)
            backgroundImage.image = UIImage(named: "firstOnboardindEN")
        case "ru":
            let imageRU = ["firstOnboardindRU", "secondOnboardindRU",
                           "thirdOnboardindRU", "fourthOnboardindRU", "fifthOnboardindRU"]
            imageModel.append(contentsOf: imageRU)
            backgroundImage.image = UIImage(named: "firstOnboardindRU")
        case "de":
            let imageDE = ["firstOnboardindDE", "secondOnboardindDE",
                           "thirdOnboardindDE", "fourthOnboardindDE", "fifthOnboardindDE"]
            imageModel.append(contentsOf: imageDE)
            backgroundImage.image = UIImage(named: "firstOnboardindDE")
        case "es":
            let imageES = ["firstOnboardindES", "secondOnboardindES",
                           "thirdOnboardindES", "fourthOnboardindES", "fifthOnboardindES"]
            imageModel.append(contentsOf: imageES)
            backgroundImage.image = UIImage(named: "firstOnboardindES")
        case "fr":
            let imageFR = ["firstOnboardindFR", "secondOnboardindFR",
                           "thirdOnboardindFR", "fourthOnboardindFR", "fifthOnboardindFR"]
            imageModel.append(contentsOf: imageFR)
            backgroundImage.image = UIImage(named: "firstOnboardindFR")
        case "it":
            let imageIT = ["firstOnboardindIT", "secondOnboardindIT",
                           "thirdOnboardindIT", "fourthOnboardindIT", "fifthOnboardindIT"]
            imageModel.append(contentsOf: imageIT)
            backgroundImage.image = UIImage(named: "firstOnboardindIT")
        default:
            let imageRU = ["firstOnboardindRU", "secondOnboardindRU",
                           "thirdOnboardindRU", "fourthOnboardindRU", "fifthOnboardindRU"]
            imageModel.append(contentsOf: imageRU)
            backgroundImage.image = UIImage(named: "firstOnboardindEN")
        }
    }
    private func setupeButton() {
        nextScreenButton.addTarget(self,
                                   action: #selector(nextScreen),
                                   for: .touchUpInside)
        subscrideButton.addTarget(self,
                                   action: #selector(subscride),
                                   for: .touchUpInside)
        closeButton.addTarget(self,
                              action: #selector(close),
                              for: .touchUpInside)
        restoreButton.addTarget(self,
                                action: #selector(pressingButton),
                                for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(pressingButton),
                              for: .touchUpInside)
        privacyButton.addTarget(self,
                                action: #selector(pressingButton),
                                for: .touchUpInside)
    }
    @objc func nextScreen() {
        viewModel?.viewAnimate(view: nextScreenButton,
                               duration: 0.2,
                               scale: 0.98)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) { [weak self] in
            guard let self else { return }
            currentImageIndex = (currentImageIndex + 1) % imageModel.count
            pageControlImage.image = UIImage(named: pageModel[currentImageIndex])
            let newImageView = UIImageView(image: UIImage(named: imageModel[currentImageIndex]))
            newImageView.contentMode = .scaleAspectFit
            newImageView.frame = self.view.bounds
            newImageView.transform = CGAffineTransform(translationX: view.bounds.width,
                                                       y: 0)
            view.addSubview(newImageView)
            view.addSubview(headerTitle)
            view.addSubview(nextScreenButton)
            view.addSubview(pageControlImage)
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundImage.transform = CGAffineTransform(translationX: -self.view.bounds.width,
                                                                   y: 0)
                newImageView.transform = .identity
            }) { _ in
                self.backgroundImage.removeFromSuperview()
                self.backgroundImage = newImageView
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 ) { [weak self] in
                guard let self else { return }
                switch currentImageIndex {
                case 1:
                    headerTitle.text = "Identify plants instantly".localized(LanguageApp.appLaunguage)
                case 2:
                    headerTitle.text = "Find out more about your pet".localized(LanguageApp.appLaunguage)
                case 3:
                    headerTitle.text = "All the answers are at your fingertips".localized(LanguageApp.appLaunguage)
                case 4:
                    view.addSubview(closeButton)
                    view.addSubview(restoreButton)
                    view.addSubview(termsButton)
                    view.addSubview(privacyButton)
                    view.addSubview(secondHeaderTitle)
                    view.addSubview(firstInfoTitle)
                    view.addSubview(firstInfoImage)
                    view.addSubview(secondInfoImage)
                    view.addSubview(secondInfoTitle)
                    view.addSubview(threeInfoImage)
                    view.addSubview(threeInfoTitle)
                    view.addSubview(priceTitle)
                    view.addSubview(subscrideButton)
                    setupLastView(true)
                default:
                    break
                }
            }
        }
    }
    @objc func subscride() {
        viewModel?.viewAnimate(view: subscrideButton,
                               duration: 0.2,
                               scale: 0.98)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) { [weak self] in
            self?.viewModel?.subscribe(to: .year)
        }
    }
    @objc func pressingButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            viewModel?.restoreSubscription()
        case 2:
            viewModel?.openWebViewController(mode: .termsOfUse)
        case 3:
            viewModel?.openWebViewController(mode: .privacyPolicy)
        default:
            break
        }
    }
    @objc func close() {
        viewModel?.setAppModel(isLogin: true,
                               isSubscirbe: false)
        viewModel?.openTabBar(botton: closeButton)
    }
    deinit {
        SKStoreReviewController.requestRateApp()
    }
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerTitle.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(40)
            make.bottom.equalTo(nextScreenButton.snp.top).inset(-30)
        }
        nextScreenButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(54)
            make.bottomMargin.equalToSuperview().inset(50)
        }
        pageControlImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(74)
            make.bottom.equalToSuperview()
        }
        
        
        closeButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(36)
        }
        restoreButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton.snp.centerY)
            make.right.equalTo(termsButton.snp.left).inset(-15)
            make.width.greaterThanOrEqualTo(50)
        }
        termsButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton.snp.centerY)
            make.right.equalTo(privacyButton.snp.left).inset(-15)
            make.height.equalTo(15)
            make.width.greaterThanOrEqualTo(50)
        }
        privacyButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton.snp.centerY)
            make.right.equalTo(-15)
            make.height.equalTo(15)
            make.width.greaterThanOrEqualTo(50)
        }
        secondHeaderTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.bottom.equalTo(firstInfoTitle.snp.top).inset(-15)
        }
        firstInfoImage.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(firstInfoTitle.snp.centerY)
            make.right.equalTo(firstInfoTitle.snp.left).inset(-10)
        }
        firstInfoTitle.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.width.lessThanOrEqualTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(secondInfoTitle.snp.top).inset(-10)
        }
        secondInfoImage.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(secondInfoTitle.snp.centerY)
            make.right.equalTo(secondInfoTitle.snp.left).inset(-10)
        }
        secondInfoTitle.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.width.lessThanOrEqualTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(threeInfoTitle.snp.top).inset(-10)
        }
        threeInfoImage.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.centerY.equalTo(threeInfoTitle.snp.centerY)
            make.right.equalTo(threeInfoTitle.snp.left).inset(-10)
        }
        threeInfoTitle.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(priceTitle.snp.top).inset(-15)
        }
        priceTitle.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(60)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalTo(subscrideButton.snp.top).inset(-20)
        }
        subscrideButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(54)
            make.bottomMargin.equalToSuperview().inset(50)
        }
    }
}
extension OnboardindViewController: SubscriptionDelegate {
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.openTabBar()
        }
    }
    func getSubscriptionData(_ data: [String]) {
        if let yearsPrice = data.first,
           let currenc = yearsPrice.unicodeScalars.first?.escaped(asASCII: true),
           let perMonth = viewModel?.removeLetters(from: yearsPrice) {
            let price = perMonth / 12
            let yearsTitle = "year".localized(LanguageApp.appLaunguage)
            let monthTitle = "month".localized(LanguageApp.appLaunguage)
            priceTitle.text = String(format: "%@ %@ %@ %.2f %@",
                                     yearsPrice,
                                     "/ \(yearsTitle) (",
                                     currenc,
                                     price,
                                     " / \(monthTitle) )")
        }
    }
}
