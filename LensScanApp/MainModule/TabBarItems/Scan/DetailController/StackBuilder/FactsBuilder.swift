//
//  FactsBuilder.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 26.11.2024.
//

import UIKit
import SnapKit

final class FactsBuilder: UIView {
    
    var isExpanded = false
    
    private var infoStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 3
        view.axis = .vertical
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private var infoTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = .systemFont(ofSize: 15,
                                weight: .semibold)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var arrowImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    var showButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupeConstraints()
        arrowImage.image = UIImage(named: "arrowImageDown")
        showButton.addTarget(self,
                             action: #selector(showInfo),
                             for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func showInfo(_ sender: UIButton) {
        sender.tag += 1
        switch sender.tag {
        case 1:
            arrowImage.transform = CGAffineTransform(rotationAngle: .pi)
        case 2:
            arrowImage.transform = CGAffineTransform(rotationAngle: .pi*2)
            sender.tag = 0
        default:
            break
        }
//        isExpanded.toggle()
//        infoStack.snp.updateConstraints { make in
//            make.height.equalTo(isExpanded ? 100 : 54)
//        }
//        UIView.animate(withDuration: 0.3) {
//            self.layoutIfNeeded()
//        }
    }
    func configure(info: String) {
        infoTitle.text = info
    }
    private func addSubviews() {
        addSubview(infoStack)
        infoStack.addSubview(infoTitle)
        infoStack.addSubview(arrowImage)
        infoStack.addSubview(showButton)
    
    }
    private func setupeConstraints() {
        infoStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(54)
            make.left.right.equalToSuperview()
        }
        infoTitle.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(arrowImage.snp.left).inset(-10)
            make.centerY.equalToSuperview()
        }
        arrowImage.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        showButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
