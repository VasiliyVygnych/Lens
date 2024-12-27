//
//  FactsCell.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 26.11.2024.
//

import UIKit
import SnapKit

class FactsCell: UITableViewCell {
  
    var subscriptionTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .light)
        view.textColor = .black
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 0
        return view
    }()
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        addSubview()
        сreatedConstraints()
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(_ text: String) {
        subscriptionTitle.text = text
    }
}
private extension FactsCell {
    func addSubview() {
        contentView.addSubview(subscriptionTitle)
    }
    func сreatedConstraints() {
        subscriptionTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.height.equalToSuperview()
            make.width.equalToSuperview().inset(10)
        }
    }
}
