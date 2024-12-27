//
//  ChatCell.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 21.11.2024.
//

import UIKit
import SnapKit

class ChatCell: UITableViewCell {
  
    var viewModel: ChatViewModelProtocol?
    var view = UIViewController()
    var model: MessageData?
    
    private var userView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    private var cornerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var messageTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16,
                                weight: .regular)
        view.textAlignment = .left
        view.numberOfLines = 0
       return view
    }()
    private var attachmentImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 14
        view.backgroundColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    private var botAvatar: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 36/2
        view.clipsToBounds = true
        return view
    }()
    private var responseTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16,
                                weight: .regular)
        view.textAlignment = .left
        view.numberOfLines = 0
       return view
    }()
    var likeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var dislikeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var shareButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var copyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var copyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    private var copyTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13,
                                weight: .medium)
        view.textAlignment = .center
       return view
    }()
    

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        self.backgroundColor = .white
        self.isUserInteractionEnabled = true
        addSubview()
        setupeColor()
        setupeImage()
        сreatedConstraints()
        setupeButton()
        
        copyTitle.text = "Copied".localized(LanguageApp.appLaunguage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupeColor() {
        userView.backgroundColor = UIColor(named: "subscrobeButtoncolor")
        cornerView.backgroundColor = UIColor(named: "subscrobeButtoncolor")
        messageTitle.textColor = .black
        responseTitle.textColor = .black
        
        copyTitle.textColor = UIColor(named: "grayCustomColor")
        copyView.backgroundColor = UIColor(named: "subscrobeButtoncolor")
    }
    private func setupeImage() {
        botAvatar.image = UIImage(named: "botAvatar")
        likeButton.setBackgroundImage(UIImage(named: "likeImage"),
                                      for: .normal)
        dislikeButton.setBackgroundImage(UIImage(named: "dislikeImage"),
                                         for: .normal)
        shareButton.setBackgroundImage(UIImage(named: "shareMessage"),
                                       for: .normal)
        copyButton.setBackgroundImage(UIImage(named: "copyMessage"),
                                      for: .normal)
    }
    func configureCell(_ model: MessageData) {
        switch model.chatAI {
        case false:
            responseTitle.isHidden = true
            botAvatar.isHidden = true
            messageTitle.isHidden = false
            userView.isHidden = false
            cornerView.isHidden = false
            messageTitle.text = model.text
            
            attachmentImage.isHidden = false
            attachmentImage.image = UIImage(data: model.image)
            
            likeButton.isHidden = true
            dislikeButton.isHidden = true
            shareButton.isHidden = true
            copyButton.isHidden = true

            if model.type == "text" && attachmentImage.image == nil {
                attachmentImage.isHidden = true
                attachmentImage.snp.updateConstraints { make in
                    make.bottom.equalTo(contentView.snp.bottom).inset(50)
                }
            } else {
                attachmentImage.snp.updateConstraints { make in
                    make.bottom.equalTo(contentView.snp.bottom).inset(10)
                }
            }
        case true:
            messageTitle.isHidden = true
            userView.isHidden = true
            cornerView.isHidden = true
            attachmentImage.isHidden = true
            botAvatar.isHidden = false
            responseTitle.isHidden = false
            responseTitle.text = model.text
            
            likeButton.isHidden = false
            dislikeButton.isHidden = false
            shareButton.isHidden = false
            copyButton.isHidden = false
        }
    }
    func setupeReactions(_ model: MessageData) {
        if model.like == true {
            likeButton.tag = 1
            dislikeButton.tag = 0
            likeButton.setBackgroundImage(UIImage(named: "likeImageTap"),
                                          for: .normal)
        } else {
            likeButton.tag = 0
            likeButton.setBackgroundImage(UIImage(named: "likeImage"),
                                          for: .normal)
        }
        if model.dislike == true {
            dislikeButton.tag = 1
            likeButton.tag = 0
            dislikeButton.setBackgroundImage(UIImage(named: "dislikeImageTap"),
                                             for: .normal)
        } else {
            dislikeButton.tag = 0
            dislikeButton.setBackgroundImage(UIImage(named: "dislikeImage"),
                                             for: .normal)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        messageTitle.text = nil
        responseTitle.text = nil
        botAvatar.isHidden = true
        attachmentImage.image = nil
        userView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(50)
        }
    }
    private func setupeButton() {
        likeButton.addTarget(self,
                             action: #selector(likeMessage),
                             for: .touchUpInside)
        dislikeButton.addTarget(self,
                             action: #selector(dislikeMessage),
                             for: .touchUpInside)
        shareButton.addTarget(self,
                             action: #selector(shareMessage),
                             for: .touchUpInside)
        copyButton.addTarget(self,
                             action: #selector(copyMessage),
                             for: .touchUpInside)
        
    }
    @objc func likeMessage(_ sender: UIButton) {
        dislikeButton.tag = 0
        viewModel?.viewAnimate(view: likeButton,
                               duration: 0.2,
                               scale: 0.96)
        sender.tag += 1
        switch sender.tag {
        case 1:
            viewModel?.editLike(true,
                                id: model?.id)
            viewModel?.editDislike(false,
                                   id: model?.id)
            likeButton.setBackgroundImage(UIImage(named: "likeImageTap"),
                                          for: .normal)
            dislikeButton.setBackgroundImage(UIImage(named: "dislikeImage"),
                                             for: .normal)
        case 2:
            viewModel?.editLike(false,
                                id: model?.id)
            likeButton.setBackgroundImage(UIImage(named: "likeImage"),
                                          for: .normal)
            sender.tag = 0
        default:
            break
        }
    }
    @objc func dislikeMessage(_ sender: UIButton) {
        viewModel?.viewAnimate(view: dislikeButton,
                               duration: 0.2,
                               scale: 0.96)
        likeButton.tag = 0
        sender.tag += 1
        switch sender.tag {
        case 1:
            viewModel?.editDislike(true,
                                   id: model?.id)
            viewModel?.editLike(false,
                                id: model?.id)
            dislikeButton.setBackgroundImage(UIImage(named: "dislikeImageTap"),
                                             for: .normal)
            likeButton.setBackgroundImage(UIImage(named: "likeImage"),
                                          for: .normal)
        case 2:
            viewModel?.editDislike(false,
                                   id: model?.id)
            dislikeButton.setBackgroundImage(UIImage(named: "dislikeImage"),
                                             for: .normal)
            sender.tag = 0
        default:
            break
        }
    }
    @objc func shareMessage() {
        viewModel?.viewAnimate(view: shareButton,
                               duration: 0.2,
                               scale: 0.96)
        guard let text = responseTitle.text, !text.isEmpty else { return }
        let activityVC = UIActivityViewController(activityItems: [text],
                                                              applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = contentView
        view.present(activityVC,
                     animated: true)
    }
    @objc func copyMessage() {
        viewModel?.viewAnimate(view: copyButton,
                               duration: 0.2,
                               scale: 0.96)
        guard let text = responseTitle.text else { return }
        UIPasteboard.general.string = text
        UIView.animate(withDuration: 0.5,
                       animations: { [weak self] in
            self?.copyView.alpha = 1
        }, completion: { finished in
            UIView.animate(withDuration: 0.5,
                           animations: { [weak self] in
                self?.copyView.alpha = 0
            })
        })
    }
}
private extension ChatCell {
    func addSubview() {
        contentView.addSubview(userView)
        userView.addSubview(cornerView)
        
        userView.addSubview(messageTitle)
        userView.addSubview(attachmentImage)
        
        contentView.addSubview(botAvatar)
        botAvatar.isHidden = true
        contentView.addSubview(responseTitle)
        contentView.addSubview(likeButton)
        contentView.addSubview(dislikeButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(copyButton)
        
        contentView.addSubview(copyView)
        copyView.addSubview(copyTitle)
        copyView.alpha = 0
    }
    func сreatedConstraints() {
        userView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(10)
            make.right.equalTo(-20)
            make.height.greaterThanOrEqualTo(50)
            make.left.equalTo(messageTitle.snp.left).inset(-10)
            make.bottom.equalTo(attachmentImage.snp.bottom).inset(-10)
        }
        cornerView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.top)
            make.right.equalTo(userView.snp.right)
            make.width.height.equalTo(35)
        }
        messageTitle.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.top).offset(15)
            make.width.lessThanOrEqualTo(300)
            make.height.greaterThanOrEqualTo(17)
            make.right.equalTo(userView.snp.right).inset(10)
        }
        attachmentImage.snp.makeConstraints { make in
            make.top.equalTo(messageTitle.snp.bottom).offset(5)
            make.left.equalTo(userView.snp.left).inset(10)
            make.right.lessThanOrEqualTo(userView.snp.right).inset(10)
            make.height.lessThanOrEqualTo(170)
            make.width.lessThanOrEqualTo(300)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
        botAvatar.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(10)
            make.left.equalTo(20)
            make.width.height.equalTo(36)
        }
        responseTitle.snp.makeConstraints { make in
            make.top.equalTo( botAvatar.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        likeButton.snp.makeConstraints { make in
            make.top.equalTo( responseTitle.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.height.equalTo(24)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }
        dislikeButton.snp.makeConstraints { make in
            make.top.equalTo(responseTitle.snp.bottom).offset(10)
            make.left.equalTo(likeButton.snp.right).inset(-10)
            make.width.height.equalTo(24)
            make.bottom.equalTo(likeButton.snp.bottom)
        }
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.left.equalTo(dislikeButton.snp.right).inset(-10)
            make.width.height.equalTo(24)
            make.bottom.equalTo(likeButton.snp.bottom)
        }
        copyButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.left.equalTo(shareButton.snp.right).inset(-10)
            make.width.height.equalTo(24)
            make.bottom.equalTo(likeButton.snp.bottom)
        }
        
        copyView.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.right.equalTo(-15)
            make.centerY.equalTo(likeButton.snp.centerY)
        }
        
        copyTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(15)
            make.right.equalTo(-10)
            make.left.equalTo(10)
        }
    }
}
