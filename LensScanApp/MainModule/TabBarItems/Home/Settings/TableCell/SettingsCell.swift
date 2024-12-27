//
//  SettingsCell.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit
import SnapKit

class SettingsCell: UITableViewCell {
  
    private var nameTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16,
                                weight: .regular)
        view.textColor = .black
        view.textAlignment = .left
       return view
    }()
    private var icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "grayColorView")
        view.alpha = 0.5
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
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(_ model: SettingsData) {
        icon.image = model.image
        nameTitle.text = model.title
    }
}
private extension SettingsCell {
    func addSubview() {
        contentView.addSubview(icon)
        contentView.addSubview(nameTitle)
        contentView.addSubview(separatorView)
    }
    func сreatedConstraints() {
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.left.equalTo(20)
        }
        nameTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).inset(-10)
            make.right.equalTo(-20)
        }
        separatorView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
