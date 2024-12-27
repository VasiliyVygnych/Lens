//
//  PopularCell.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit
import SnapKit

class PopularCell: UICollectionViewCell {
    
    var viewModel: HomeViewModelProtocol?
    
    private var previewImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        view.contentMode = .scaleAspectFill
        return view
    }()
    private var nameTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .semibold)
        view.textColor = .black
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
       return view
    }()
    private var descriptionTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13,
                                weight: .light)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
       return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
        setupeConstraint()
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureData(_ model: PopularData) {
        previewImage.image = model.image
        nameTitle.text = model.title
        descriptionTitle.text = model.subtitle
    }
}
private extension PopularCell {
    func initialization() {
        contentView.addSubview(previewImage)
        contentView.addSubview(nameTitle)
        contentView.addSubview(descriptionTitle)
    }
    func setupeConstraint() {
        previewImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.centerY).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
        }
        descriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
