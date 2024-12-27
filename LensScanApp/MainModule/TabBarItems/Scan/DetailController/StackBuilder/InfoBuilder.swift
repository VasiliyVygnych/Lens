//
//  StackBuilder.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 26.11.2024.
//

import UIKit
import SnapKit

final class InfoBuilder: UIView {
    
    private var infoStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 3
        view.axis = .vertical
        view.backgroundColor = .clear
        return view
    }()
    private var previewImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    private var infoTitle: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "infoTitleColor")
        view.font = .systemFont(ofSize: 15,
                                weight: .light)
        view.textAlignment = .right
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var infoLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = .systemFont(ofSize: 15,
                                weight: .bold)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(info: String,
                   label: String?,
                   image: UIImage?) {
        previewImage.image = image
        infoTitle.text = info
        infoLabel.text = label
    }
    private func addSubviews() {
        addSubview(infoStack)
        addSubview(previewImage)
        
        
        infoStack.addSubview(infoTitle)
        infoStack.addSubview(infoLabel)
    }
    private func setupeConstraints() {
        infoStack.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        previewImage.snp.makeConstraints { make in
            make.width.height.equalTo(46)
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        infoLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.right.equalTo(infoTitle.snp.left).inset(-10)
            make.left.equalTo(previewImage.snp.right).inset(-15)
            make.centerY.equalToSuperview()
        }
        infoTitle.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.right.equalTo(-20)
            make.left.equalTo(infoLabel.snp.right).inset(-10)
            make.centerY.equalToSuperview()
        }
        
    }
}
