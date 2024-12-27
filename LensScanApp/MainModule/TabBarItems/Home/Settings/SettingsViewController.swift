//
//  SettingsViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit
import SnapKit
import MessageUI
import StoreKit

class SettingsViewController: UIViewController,
                                MFMailComposeViewControllerDelegate {
    
    var viewModel: HomeViewModelProtocol?
    private var cellIdentifier = "settingsCell"
    private let hideSeparator = [IndexPath(row: 1,
                                           section: 0),
                                 IndexPath(row: 2,
                                           section: 1),
                                 IndexPath(row: 1,
                                           section: 2)]
    
    private var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var subscribeBannerImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.isUserInteractionEnabled = true
        return view
    }()
    private var subscribeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    private var subscribeTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .bold)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 2
        return view
    }()
    private var subscribeBannerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var subscribeBannerSubtitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13,
                                weight: .light)
        view.textAlignment = .left
        return view
    }()
    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        setupUI()
        setuteTableView()
        setupText()
        setupColor()
        setupImage()
        setupeButton()
        setupConstraints()
    }
    private func setuteTableView() {
        tableView.register(SettingsCell.self,
                    forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.rowHeight = 60
    }
    private func setupUI() {
        view.addSubview(backButton)
        
        view.addSubview(subscribeBannerImage)
        subscribeBannerImage.addSubview(subscribeButton)
        subscribeButton.addSubview(subscribeTitle)
        subscribeBannerImage.addSubview(subscribeBannerTitle)
        subscribeBannerImage.addSubview(subscribeBannerSubtitle)
        
        view.addSubview(tableView)
    }
    private func setupText() {
        subscribeTitle.text = "Try for Free".localized(LanguageApp.appLaunguage)
        subscribeBannerTitle.text = "Try Premium".localized(LanguageApp.appLaunguage)
        subscribeBannerSubtitle.text = "Get unlimited access".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .white
        subscribeButton.backgroundColor = UIColor(named: "customBlueColor")
        subscribeTitle.textColor = .white
        subscribeBannerTitle.textColor = .black
        subscribeBannerSubtitle.textColor = .black
        tableView.backgroundColor = .white
    }
    private func setupImage() {
        backButton.setBackgroundImage(UIImage(named: "arrowLeft"),
                                      for: .normal)
        subscribeBannerImage.image = UIImage(named: "subscribeSettingsBanner")
        
        
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        subscribeButton.addTarget(self,
                                  action: #selector(openPayWall),
                                  for: .touchUpInside)
        
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: true)
    }
    @objc func openPayWall() {
        viewModel?.viewAnimate(view: subscribeButton,
                               duration: 0.2,
                               scale: 0.97)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.viewModel?.openPayWallController()
        }
     }
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(24)
        }
        
        subscribeBannerImage.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(50)
            make.left.equalTo(30)
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(140)
        }
        subscribeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(15)
            make.right.equalTo(-15)
        }
        subscribeTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        subscribeBannerTitle.snp.makeConstraints { make in
            make.right.lessThanOrEqualTo(subscribeButton.snp.left).inset(-5)
            make.height.equalTo(20)
            make.left.equalTo(20)
            make.bottom.equalTo(subscribeBannerSubtitle.snp.top).inset(-5)
        }
        subscribeBannerSubtitle.snp.makeConstraints { make in
            make.right.lessThanOrEqualTo(subscribeButton.snp.left).inset(-5)
            make.height.equalTo(15)
            make.left.equalTo(20)
            make.bottom.equalToSuperview().inset(15)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subscribeBannerImage.snp.bottom)
            make.width.equalToSuperview()
            make.bottomMargin.equalToSuperview()
        }
    }
    private func rateApp() {
        let url = URL(string: "https://apps.apple.com/us/app/id000000000")
        let view = UIActivityViewController(activityItems: [url as Any],
                                            applicationActivities: nil)
        present(view,
                animated: true)
    }
}
extension SettingsViewController: UITableViewDataSource,
                                  UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        settingsData[section].data.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        settingsData.count
    }
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        settingsData[section].name
    }
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = .white
            header.textLabel?.textColor = UIColor(named: "colorBlack70")
        }
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? SettingsCell else { return UITableViewCell() }
        let data = settingsData[indexPath.section].data[indexPath.row]
        cell.configureCell(data)
        if hideSeparator.contains(indexPath) {
            cell.separatorView.isHidden = true
        } else {
            cell.separatorView.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let data = settingsData[indexPath.section].data[indexPath.row]
            viewModel?.viewAnimate(view: cell,
                                   duration: 0.2,
                                   scale: 0.98)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                switch data.type {
                case .restore:
                    self?.viewModel?.restoreSubscription()
                case .help:
                    self?.sendMessage(title: "Help".localized(LanguageApp.appLaunguage))
                case .share:
                    self?.rateApp()
                case .rate:
                    SKStoreReviewController.requestRateApp()
                case .suggest:
                    self?.sendMessage(title: "Suggest Idea".localized(LanguageApp.appLaunguage))
                case .privacy:
                    self?.viewModel?.openWebViewController(mode: .privacyPolicy)
                case .terms:
                    self?.viewModel?.openWebViewController(mode: .termsOfUse)
                }
            }
        }
    }
    private func sendMessage(title: String) {
        guard MFMailComposeViewController.canSendMail() else {
                print("Почтовый клиент недоступен")
            return
        }
        let view = MFMailComposeViewController()
        view.mailComposeDelegate = self
        view.setToRecipients(["marbeyoel0@gmail.com"])
        view.setSubject(title)
        view.setMessageBody("Write something here..".localized(LanguageApp.appLaunguage),
                            isHTML: false)
        present(view,
                animated: true)
    }
}
