//
//  PayWallController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import SnapKit

class PayWallController: UIViewController {
    
    var viewModel: OnboardingViewModelProtocol?
    private var subscrideType = Subscription.trial
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var closeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var headerTitle: UILabel = {
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
        view.textAlignment = .left
        view.numberOfLines = 0
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
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
        view.textAlignment = .left
        view.numberOfLines = 0
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
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
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 2
        return view
    }()
    
    private var trialButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 14
        view.titleLabel?.font = .systemFont(ofSize: 15,
                                            weight: .bold)
        view.tag = 1
        return view
    }()
    private var selectTrialImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20/2
        view.clipsToBounds = true
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    private var trialTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 17,
                                weight: .bold)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var trialPriceTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 15,
                                weight: .medium)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    private var yearsButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 14
        view.titleLabel?.font = .systemFont(ofSize: 15,
                                            weight: .bold)
        view.tag = 2
        return view
    }()
    private var selectYearsImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20/2
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    private var yearsTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 17,
                                weight: .bold)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var yearsPriceTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 15,
                                weight: .medium)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    private var saveView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    private var saveTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 11,
                                weight: .bold)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    private var subscrideButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 25
        view.titleLabel?.font = .systemFont(ofSize: 15,
                                            weight: .bold)
        return view
    }()
    
    private var restoreButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .systemFont(ofSize: 12,
                                            weight: .light)
        view.titleLabel?.textAlignment = .right
        view.tag = 1
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.titleLabel?.minimumScaleFactor = 0.2
        return view
    }()
    private var termsButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .systemFont(ofSize: 12,
                                            weight: .light)
        view.titleLabel?.textAlignment = .center
        view.tag = 2
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.titleLabel?.minimumScaleFactor = 0.2
        return view
    }()
    private var privacyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .systemFont(ofSize: 12,
                                            weight: .light)
        view.titleLabel?.textAlignment = .left
        view.tag = 3
        view.titleLabel?.adjustsFontSizeToFitWidth = true
        view.titleLabel?.minimumScaleFactor = 0.2
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
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
        view.addSubview(closeButton)
        
        view.addSubview(headerTitle)
        
        view.addSubview(firstInfoTitle)
        view.addSubview(firstInfoImage)
        
        view.addSubview(secondInfoImage)
        view.addSubview(secondInfoTitle)
        
        view.addSubview(threeInfoImage)
        view.addSubview(threeInfoTitle)
        
        view.addSubview(trialButton)
        trialButton.addSubview(selectTrialImage)
        trialButton.addSubview(trialTitle)
        trialButton.addSubview(trialPriceTitle)
        
        view.addSubview(yearsButton)
        yearsButton.addSubview(selectYearsImage)
        yearsButton.addSubview(yearsTitle)
        yearsButton.addSubview(yearsPriceTitle)
        
        yearsButton.addSubview(saveView)
        saveView.addSubview(saveTitle)
        
        view.addSubview(subscrideButton)
        
        view.addSubview(restoreButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    private func setupText() {
        subscrideButton.setTitle("Try for free".localized(LanguageApp.appLaunguage),
                                 for: .normal)
        yearsTitle.text = "Yearly access".localized(LanguageApp.appLaunguage)
        trialTitle.text = "3 days free trial".localized(LanguageApp.appLaunguage)
        
        let savetitle = "Sale".localized(LanguageApp.appLaunguage)
        saveTitle.text = "\(savetitle) 87%"
        headerTitle.text = "Get Full Access to Lens Photo".localized(LanguageApp.appLaunguage)
        firstInfoTitle.text = "Identify any object in seconds".localized(LanguageApp.appLaunguage)
        secondInfoTitle.text = "Gain useful insights and tips".localized(LanguageApp.appLaunguage)
        threeInfoTitle.text = "Get personal AI Assistant".localized(LanguageApp.appLaunguage)
        
        restoreButton.setTitle("Restore".localized(LanguageApp.appLaunguage),
                               for: .normal)
        restoreButton.titleLabel?.font = .systemFont(ofSize: 14,
                                                  weight: .medium)
        termsButton.setTitle("Terms".localized(LanguageApp.appLaunguage),
                             for: .normal)
        termsButton.titleLabel?.font = .systemFont(ofSize: 14,
                                                  weight: .medium)
        privacyButton.setTitle("Privacy".localized(LanguageApp.appLaunguage),
                               for: .normal)
        privacyButton.titleLabel?.font = .systemFont(ofSize: 14,
                                                  weight: .medium)
    }
    private func setupColor() {
        view.backgroundColor = .white
        subscrideButton.backgroundColor = UIColor(named: "customBlueColor")
        subscrideButton.setTitleColor(.white,
                                      for: .normal)
        
        trialButton.backgroundColor = UIColor(named: "subscrobeButtoncolor")
        yearsButton.backgroundColor = UIColor(named: "subscrobeButtoncolor")
        yearsTitle.textColor = .black
        yearsPriceTitle.textColor = UIColor(named: "grayColorView")
        trialTitle.textColor = .black
        trialPriceTitle.textColor = UIColor(named: "grayColorView")
        saveView.backgroundColor = UIColor(named: "yellowCustomColor")
        saveTitle.textColor = UIColor(named: "violetCustomColor")
        
        threeInfoTitle.textColor = .black
        secondInfoTitle.textColor = .black
        firstInfoTitle.textColor = .black
        
        privacyButton.setTitleColor(UIColor(named: "grayColorView"),
                                    for: .normal)
        restoreButton.setTitleColor(UIColor(named: "grayColorView"),
                                 for: .normal)
        termsButton.setTitleColor(UIColor(named: "grayColorView"),
                                 for: .normal)
    }
    private func setupImage() {
        backgroundImage.image = UIImage(named: "backgroundPayWall")
        closeButton.setBackgroundImage(UIImage(named: "closeButton"),
                                       for: .normal)
        
        firstInfoImage.image = UIImage(named: "payWallImageFirst")
        secondInfoImage.image = UIImage(named: "payWallImageSecond")
        threeInfoImage.image = UIImage(named: "payWallImageThree")
        selectTrialImage.image = UIImage(named: "selectImage")
    }
    private func setupeButton() {
        subscrideButton.addTarget(self,
                                  action: #selector(subscride),
                                  for: .touchUpInside)
        closeButton.addTarget(self,
                              action: #selector(popToView),
                              for: .touchUpInside)
        trialButton.addTarget(self,
                              action: #selector(tapButton),
                              for: .touchUpInside)
        yearsButton.addTarget(self,
                              action: #selector(tapButton),
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
    @objc func popToView() {
        navigationController?.popViewController(animated: false)
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
    @objc func subscride() {
        viewModel?.viewAnimate(view: subscrideButton,
                               duration: 0.2,
                               scale: 0.98)
        viewModel?.subscribe(to: subscrideType)
    }
    @objc func tapButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            viewModel?.viewAnimate(view: trialButton,
                                   duration: 0.2,
                                   scale: 0.98)
            selectTrialImage.image = UIImage(named: "selectImage")
            selectTrialImage.layer.borderWidth = 0
            selectYearsImage.image = nil
            selectYearsImage.layer.borderWidth = 1
            subscrideType = .trial
        case 2:
            viewModel?.viewAnimate(view: yearsButton,
                                   duration: 0.2,
                                   scale: 0.98)
            selectTrialImage.image = nil
            selectTrialImage.layer.borderWidth = 1
            selectYearsImage.layer.borderWidth = 0
            selectYearsImage.image = UIImage(named: "selectImage")
            subscrideType = .year
        default:
            break
        }
    }
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(36)
        }
        
        
        headerTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(40)
            make.height.equalTo(60)
            make.bottom.equalTo(firstInfoTitle.snp.top).inset(-15)
        }
        
        firstInfoImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(firstInfoTitle.snp.centerY)
            make.right.equalTo(firstInfoTitle.snp.left).inset(-10)
        }
        firstInfoTitle.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.right.equalTo(-20)
            make.left.equalTo(secondInfoTitle.snp.left)
            make.bottom.equalTo(secondInfoTitle.snp.top).inset(-20)
        }
       
        secondInfoImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(secondInfoTitle.snp.centerY)
            make.right.equalTo(secondInfoTitle.snp.left).inset(-10)
        }
        secondInfoTitle.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.right.equalTo(-20)
            make.left.equalTo(threeInfoTitle.snp.left)
            make.bottom.equalTo(threeInfoTitle.snp.top).inset(-20)
        }
        
        threeInfoImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(threeInfoTitle.snp.centerY)
            make.right.equalTo(threeInfoTitle.snp.left).inset(-10)
        }
        threeInfoTitle.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(40)
            make.width.lessThanOrEqualTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(trialButton.snp.top).inset(-20)
        }
        
        
        
        trialButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(64)
            make.bottom.equalTo(yearsButton.snp.top).inset(-10)
        }
        selectTrialImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.width.height.equalTo(20)
        }
        trialTitle.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(selectTrialImage.snp.right).inset(-15)
            make.height.equalTo(20)
            make.right.equalTo(-20)
        }
        trialPriceTitle.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.left.equalTo(selectTrialImage.snp.right).inset(-15)
            make.height.equalTo(20)
            make.right.equalTo(-20)
        }
        
        yearsButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(64)
            make.bottom.equalTo(subscrideButton.snp.top).inset(-20)
        }
        selectYearsImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.width.height.equalTo(20)
        }
        yearsTitle.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(selectYearsImage.snp.right).inset(-15)
            make.height.equalTo(20)
            make.right.lessThanOrEqualTo(saveView.snp.left).inset(-5)
        }
        yearsPriceTitle.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.left.equalTo(selectYearsImage.snp.right).inset(-15)
            make.height.equalTo(20)
            make.right.equalTo(-20)
        }
        
        saveView.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.height.equalTo(25)
            make.top.equalTo(10)
        }
        saveTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(15)
        }
        
        subscrideButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(54)
            make.bottom.equalTo(restoreButton.snp.top).inset(-20)
        }
    
        restoreButton.snp.makeConstraints { make in
            make.right.equalTo(termsButton.snp.left).inset(-5)
            make.left.equalTo(15)
            make.height.equalTo(20)
            make.bottomMargin.equalToSuperview().inset(20)
        }
        termsButton.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.bottomMargin.equalToSuperview().inset(20)
        }
        privacyButton.snp.makeConstraints { make in
            make.left.equalTo(termsButton.snp.right).inset(-5)
            make.right.equalTo(-15)
            make.height.equalTo(20)
            make.bottomMargin.equalToSuperview().inset(20)
        }
    }
}
extension PayWallController: SubscriptionDelegate {
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel?.openTabBar()
        }
    }
    func getSubscriptionData(_ data: [String]) {
        if let yearsPrice = data.first,
           let weekPrice = data.last {
            yearsPriceTitle.text = String(format: "%@ %@ %@",
                                          "just".localized(LanguageApp.appLaunguage),
                                          yearsPrice,
                                          "per year".localized(LanguageApp.appLaunguage))
            trialPriceTitle.text = String(format: "%@ %@ %@",
                                          "then".localized(LanguageApp.appLaunguage),
                                          weekPrice,
                                          "per week".localized(LanguageApp.appLaunguage))
        }
    }
}
