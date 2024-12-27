//
//  LoaderView.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 26.11.2024.
//

import UIKit
import SnapKit

class LoaderView: UIView {
    
    var activityInditacor = UIActivityIndicatorView()
    var timer: Timer?
    private var dotCount = 0
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var loadTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17,
                                weight: .semibold)
        view.textAlignment = .center
        return view
    }()
    
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview()
        setupeConstraints()
        backgroundImage.image = UIImage(named: "loadBackground")
        loadTitle.text = "Scanning".localized(LanguageApp.appLaunguage)
        loadTitle.textColor = .black
        activityInditacor.color = .black
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubview() {
        addSubview(backgroundImage)
        addSubview(loadTitle)
        addSubview(activityInditacor)
    }
    func startAnimatingDots() {
        activityInditacor.startAnimating()
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(updateLabel),
                                     userInfo: nil,
                                     repeats: true)
    }
    @objc private func updateLabel() {
        dotCount = (dotCount + 1) % 4
        let dots = String(repeating: ".",
                          count: dotCount)
        let title = "Scanning".localized(LanguageApp.appLaunguage)
        loadTitle.text = "\(title)\(dots)"
    }
    func stopAnimatingDots() {
        activityInditacor.stopAnimating()
        timer?.invalidate()
    }
    deinit {
        timer?.invalidate()
    }
    private func setupeConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.centerY.equalToSuperview().offset(50)
            make.width.equalToSuperview()
        }
        
        activityInditacor.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(200)
        }
        
    }
}
