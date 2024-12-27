//
//  ResultCell.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 25.11.2024.
//

import UIKit
import SnapKit
import SDWebImage

class ResultCell: UICollectionViewCell {
    
    var viewModel: ScanViewModelProtocol?
    
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
        view.font = .systemFont(ofSize: 13,
                                weight: .semibold)
        view.textColor = .black
        view.textAlignment = .left
//        view.adjustsFontSizeToFitWidth = true
//        view.minimumScaleFactor = 0.2
       return view
    }()
    private var sourceTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 11,
                                weight: .light)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .left
//        view.adjustsFontSizeToFitWidth = true
//        view.minimumScaleFactor = 0.2
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
    func configureData(_ model: ItemResult) {
        let url = URL(string: model.imageURL)
        previewImage.sd_setImage(with: url)
        
        nameTitle.text = model.title
        sourceTitle.text = model.source
    }
}
private extension ResultCell {
    func initialization() {
        contentView.addSubview(previewImage)
        contentView.addSubview(nameTitle)
        contentView.addSubview(sourceTitle)
    }
    func setupeConstraint() {
        previewImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        nameTitle.snp.makeConstraints { make in
            make.top.equalTo(previewImage.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.height.equalTo(16)
        }
        sourceTitle.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.height.equalTo(12)
        }
    }
}
