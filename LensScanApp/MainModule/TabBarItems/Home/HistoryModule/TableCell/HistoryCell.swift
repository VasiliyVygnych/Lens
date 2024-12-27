//
//  HistoryCell.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit
import SnapKit

class HistoryCell: UITableViewCell {
  
    var viewModel: HomeViewModelProtocol?
    var model: SearchData?
    weak var delegate: HistoryCellDelegate?
    
    private var previewImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    private var nameTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16,
                                weight: .bold)
        view.textColor = .black
        view.textAlignment = .left
       return view
    }()
    private var timeTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13,
                                weight: .light)
        view.textColor = .black
        view.textAlignment = .left
       return view
    }()
    
    var favoriteButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        addSubview()
        сreatedConstraints()
        contentView.backgroundColor = .white
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
        favoriteButton.setBackgroundImage(UIImage(named: "favoriteImageOff"),
                                          for: .normal)
        favoriteButton.addTarget(self,
                                 action: #selector(editFavorite),
                                 for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(_ model: SearchData) {
        previewImage.image = UIImage(data: model.preview)
        nameTitle.text = model.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM HH:mm"
        timeTitle.text = dateFormatter.string(from: model.dateOfCreate)
        
        if model.isVavorite == true {
            favoriteButton.setBackgroundImage(UIImage(named: "favoriteImageOn"),
                                              for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(named: "favoriteImageOff"),
                                              for: .normal)
        }
    }
    @objc func editFavorite(_ sender: UIButton) {
        sender.tag += 1
        switch sender.tag {
        case 1:
            viewModel?.editFavorite(true,
                                    id: model?.id)
            favoriteButton.setBackgroundImage(UIImage(named: "favoriteImageOn"),
                                              for: .normal)
        case 2:
            viewModel?.editFavorite(false,
                                    id: model?.id)
            favoriteButton.setBackgroundImage(UIImage(named: "favoriteImageOff"),
                                              for: .normal)
            sender.tag = 0
            delegate?.reloadData()
        default:
            break
        }
    }
}
private extension HistoryCell {
    func addSubview() {
        contentView.addSubview(previewImage)
        contentView.addSubview(nameTitle)
        contentView.addSubview(timeTitle)
        
        
        contentView.addSubview(favoriteButton)
    }
    func сreatedConstraints() {
        previewImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.width.height.equalTo(86)
        }
        nameTitle.snp.makeConstraints { make in
            make.left.equalTo(previewImage.snp.right).inset(-15)
            make.right.equalTo(favoriteButton.snp.left).inset(-10)
            make.top.equalTo(previewImage.snp.top).offset(20)
        }
        timeTitle.snp.makeConstraints { make in
            make.left.equalTo(previewImage.snp.right).inset(-15)
            make.right.equalTo(favoriteButton.snp.left).inset(-10)
            make.bottom.equalTo(previewImage.snp.bottom).inset(20)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
            make.width.height.equalTo(24)
        }
    }
}
