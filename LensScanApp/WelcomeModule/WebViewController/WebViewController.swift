//
//  WebViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit
import SnapKit
import WebKit

class WebViewController: UIViewController {
    
    var viewModel: OnboardingViewModelProtocol?
    private var webView = WKWebView()
    var mode = SettingsWebView.none
    
    private var viewTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = .systemFont(ofSize: 20,
                                 weight: .semibold)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var backToView: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        setupeWebView()
        addSubview()
        setuprData()
        setupeConstraint()
        backToView.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        setupeWebView(mode)
    }
    private func setuprData() {
        backToView.setBackgroundImage(UIImage(named: "arrowLeft"),
                                      for: .normal)
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: true)
    }
    func setupeWebView(_ mode: SettingsWebView) {
        switch mode {
        case .privacyPolicy:
            viewTitle.text = "Privacy Policy".localized(LanguageApp.appLaunguage)
            if let url = URL(string: "https://google.com") {
                webView.load(URLRequest(url: url))
            }
        case .termsOfUse:
            viewTitle.text = "Terms of Use".localized(LanguageApp.appLaunguage)
            if let url = URL(string: "https://google.com") {
                webView.load(URLRequest(url: url))
            }
        case .none:
            break
        }
    }
    private func setupeWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .white
    }
    private func addSubview() {
        view.addSubview(backToView)
        view.addSubview(viewTitle)
    }
    private func setupeConstraint() {
        viewTitle.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.height.equalTo(22)
            make.left.equalTo(30)
            make.width.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        backToView.snp.makeConstraints { make in
            make.centerY.equalTo(viewTitle.snp.centerY)
            make.width.height.equalTo(33)
            make.left.equalTo(20)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.width.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(30)
        }
    }
}
