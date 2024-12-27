//
//  ChatViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import SnapKit
import PhotosUI
import StoreKit

class ChatViewController: UIViewController {
    
    var viewModel: ChatViewModelProtocol?
    private var selectPhoto: UIImage?
    private var cellIdentifier = "chatCell"
    private var gesture = UITapGestureRecognizer()
    private var messages: [ChatData] = []
    private var model: [MessageData]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .semibold)
        view.textAlignment = .center
        return view
    }()
    private var emptyImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.allowsSelection = false
        return view
    }()
    private var messageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        return view
    }()
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var sendButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var addPhotoCameraButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var addPhotoGalagyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var messageTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16,
                                weight: .medium)
        view.isScrollEnabled = false
        view.scrollsToTop = false
        view.backgroundColor = .clear
        view.keyboardType = .default
        view.isUserInteractionEnabled = true
        return view
    }()
    private var messagePlaceholder: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .medium)
        view.textAlignment = .left
        return view
    }()
    private var removeAttachment: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var attachmentImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        setuteTableView()
        setupText()
        setupColor()
        setupImage()
        setupeButton()
        setupConstraints()
        viewModel?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(willShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
//        viewModel?.removeMessageData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        setupData()
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        if let data = model {
            if data.count > 0 {
                let lastIndexPath = IndexPath(row: data.count - 1,
                                              section: 0)
                tableView.scrollToRow(at: lastIndexPath,
                                      at: .bottom,
                                      animated: false)
            }
        }
    }
    private func setupData() {
        model = viewModel?.getMessageData(true)
    }
    private func setuteTableView() {
        tableView.register(ChatCell.self,
                    forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
    }
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(headerTitle)
        
        view.addSubview(tableView)
        view.addSubview(emptyImage)
        
        view.addSubview(contentView)
        view.addSubview(separatorView)
        contentView.addSubview(messageView)
        contentView.addSubview(sendButton)
        sendButton.isEnabled = false
        sendButton.alpha = 0.7
        messageView.addSubview(addPhotoGalagyButton)
        messageView.addSubview(addPhotoCameraButton)
        
        contentView.addSubview(attachmentImage)
        contentView.addSubview(removeAttachment)
        removeAttachment.isHidden = true
        
        messageView.addSubview(messageTextView)
        messageTextView.delegate = self
        messageView.addSubview(messagePlaceholder)
    }
    private func setupText() {
        headerTitle.text = "Chat AI".localized(LanguageApp.appLaunguage)
        messagePlaceholder.text = "Talk with chat AI".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .white
        headerTitle.textColor = .black
        contentView.backgroundColor = .white
        separatorView.backgroundColor = UIColor(named: "subscrobeButtoncolor")
        messageView.backgroundColor = UIColor(named: "subscrobeButtoncolor")
        messagePlaceholder.textColor = .lightGray
        messageTextView.textColor = .black
        tableView.backgroundColor = .white
        view.backgroundColor = UIColor(named: "subscrobeButtoncolor")
    }
    private func setupImage() {
        backButton.setBackgroundImage(UIImage(named: "arrowLeft"),
                                      for: .normal)
        emptyImage.image = UIImage(named: "emptyChatImage")
        sendButton.setBackgroundImage(UIImage(named: "sendImage"),
                                      for: .normal)
        addPhotoCameraButton.setBackgroundImage(UIImage(named: "photoCamera"),
                                                for: .normal)
        addPhotoGalagyButton.setBackgroundImage(UIImage(named: "photoGalagy"),
                                                for: .normal)
        removeAttachment.setBackgroundImage(UIImage(named: "removeRoundImage"),
                                            for: .normal)
        tableView.addGestureRecognizer(gesture)
        gesture.addTarget(self,
                          action: #selector(isHide))
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        sendButton.addTarget(self,
                             action: #selector(sendMessage),
                             for: .touchUpInside)
        addPhotoGalagyButton.addTarget(self,
                                       action: #selector(openGalary),
                                       for: .touchUpInside)
        addPhotoCameraButton.addTarget(self,
                                       action: #selector(openScan),
                                       for: .touchUpInside)
        removeAttachment.addTarget(self,
                                   action: #selector(deleteImage),
                                   for: .touchUpInside)
    }
    @objc func isHide() {
        view.endEditing(true)
    }
    @objc func deleteImage() {
        attachmentImage.image = nil
        removeAttachment.isHidden = true
        attachmentImage.isHidden = true
        addPhotoCameraButton.isHidden = false
        addPhotoGalagyButton.isHidden = false
        attachmentImage.snp.updateConstraints { make in
            make.height.equalTo(0)
            make.bottom.equalTo(messageView.snp.top).inset(0)
        }
        if messageTextView.text.count < 30 {
            messageTextView.snp.updateConstraints { make in
                make.top.equalTo(12)
                make.left.equalTo(70)
            }
        } else {
            messageTextView.snp.updateConstraints { make in
                make.top.equalTo(35)
            }
        }
    }
    @objc func openScan() {
        viewModel?.openScanController(searchType: .chatAI,
                                      delegate: self)
    }
    @objc func openGalary() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .denied,
                .restricted:
            break
        case .limited,
                .authorized,
                .notDetermined:
            selectPhotos()
        @unknown default:
            break
        }
    }
    private func selectPhotos() {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker,
                animated: true)
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: true)
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = false
            tabBarController.selectedIndex = 0
        }
    }
    @objc func sendMessage() {
        viewModel?.viewAnimate(view: sendButton,
                               duration: 0.2,
                               scale: 0.98)
        let imageData: Data? = selectPhoto?.jpegData(compressionQuality: 0.5)
        let imageStr = imageData?.base64EncodedString()
        sendMessageUser(text: messageTextView.text,
                        imageStr: imageStr)
        view.endEditing(true)
        messagePlaceholder.isHidden = false
        messageTextView.text = nil
        deleteImage()
    }
    func sendMessageUser(text: String,
                         imageStr: String?) {
        if selectPhoto == nil {
            let data = ChatData(role: "user",
                                imageStr: "",
                                text: text,
                                tupe: "text",
                                chatAI: false,
                                image: nil)
            messages.append(data)
        } else {
            let data = ChatData(role: "user",
                                imageStr: imageStr,
                                text: text,
                                tupe: "image",
                                chatAI: false,
                                image: selectPhoto)
            messages.append(data)
        }
        if let message = messages.last {
            viewModel?.sendMessage(data: message)
            setChatData(message)
            selectPhoto = nil
        }
        tableView.scrollToRow(at: IndexPath(row: (model?.count ?? 0) - 1,
                                            section: 0),
                              at: .bottom,
                              animated: true)
    }
    func sendMessageShat(text: String) {
        let data = ChatData(role: "model",
                            imageStr: "",
                            text: text,
                            tupe: "text",
                            chatAI: true,
                            image: nil)
        messages.append(data)
        if let message = messages.last {
            setChatData(message)
        }
        tableView.scrollToRow(at: IndexPath(row: (model?.count ?? 0) - 1,
                                            section: 0),
                              at: .bottom,
                              animated: true)
    }
    private func setChatData(_ data: ChatData) {
        viewModel?.setMessageData(chatData: data)
        model = viewModel?.getMessageData(true)
    }
    @objc func willShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardSize.height + 20
            }
        }
    }
    @objc func willHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(24)
        }
        headerTitle.snp.makeConstraints { make in
            make.centerY.equalTo( backButton.snp.centerY)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        emptyImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(133)
            make.topMargin.equalTo(150)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(110)
        }
        
        separatorView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalTo(contentView.snp.top)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        attachmentImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(10)
            make.left.equalTo(20)
            make.width.equalTo(80)
            make.height.equalTo(0)
            make.bottom.equalTo(messageView.snp.top).inset(0)
        }
        removeAttachment.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.right.equalTo(attachmentImage.snp.right).inset(-3)
            make.top.equalTo(attachmentImage.snp.top).inset(-3)
        }
        
        messageView.snp.makeConstraints { make in
            make.right.equalTo(sendButton.snp.left).inset(-10)
            make.left.equalTo(20)
            make.height.greaterThanOrEqualTo(60)
            make.bottom.equalToSuperview().inset(40)
        }
        
        sendButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.width.height.equalTo(24)
            make.bottom.equalTo(messageView.snp.bottom).inset(18)
        }
        addPhotoCameraButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.width.height.equalTo(24)
            make.left.equalTo(15)
        }
        addPhotoGalagyButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.left.equalTo(addPhotoCameraButton.snp.right).inset(-5)
            make.top.equalTo(addPhotoCameraButton.snp.top)
        }
        messageTextView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(75)
            make.right.equalTo(-20)
            make.bottom.equalToSuperview().inset(10)
        }
        messagePlaceholder.snp.makeConstraints { make in
            make.centerY.equalTo(messageTextView.snp.centerY)
            make.left.equalTo(messageTextView.snp.left)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
    }
}
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        messageTextView.text = textView.text
        if textView.text.isEmpty {
            messagePlaceholder.isHidden = false
            sendButton.isEnabled = false
            sendButton.alpha = 0.7
        } else {
            messagePlaceholder.isHidden = true
            sendButton.isEnabled = true
            sendButton.alpha = 1
        }
        let size = CGSize(width: textView.frame.width,
                          height: .greatestFiniteMagnitude)
        let estimatedSize = textView.sizeThatFits(size)
        let numberOfLines = Int(estimatedSize.height / textView.font!.lineHeight)
        if numberOfLines > 1 {
            if attachmentImage.image == nil {
                messageTextView.snp.updateConstraints { make in
                    make.top.equalTo(35)
                    make.left.equalTo(20)
                }
            }
        }
        if textView.text.count < 30 {
            if attachmentImage.image == nil {
                messageTextView.snp.updateConstraints { make in
                    make.top.equalTo(12)
                    make.left.equalTo(70)
                }
            } else {
                messageTextView.snp.updateConstraints { make in
                    make.top.equalTo(12)
                    make.left.equalTo(20)
                }
            }
        }
    }
}
extension ChatViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }
                            self.selectPhoto = image
                            self.viewModel?.openCropController(delegate: self,
                                                               photo: image)
                            self.view.endEditing(true)
                        }
                    }
                }
            }
        }
    }
}
extension ChatViewController: UITableViewDataSource,
                                UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? ChatCell,
              let model = model?[indexPath.row] else { return UITableViewCell() }
        cell.viewModel = viewModel
        cell.configureCell(model)
        cell.setupeReactions(model)
        cell.view = self
        cell.model = model
        emptyImage.isHidden = true
        return cell
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ChatViewController: CropPhotoDelegate {
    func didSelectPhoto(_ photo: UIImage?) {
        view.endEditing(true)
        selectPhoto = photo
        attachmentImage.image = photo
        attachmentImage.isHidden = false
        removeAttachment.isHidden = false
        addPhotoCameraButton.isHidden = true
        addPhotoGalagyButton.isHidden = true
        attachmentImage.snp.updateConstraints { make in
            make.height.equalTo(80)
            make.bottom.equalTo(messageView.snp.top).inset(-10)
        }
        messageTextView.snp.updateConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(20)
        }
    }
}
extension ChatViewController: ChatViewDelegate {
    func chatResponse(_ text: String?) {
        if let text = text {
            view.endEditing(true)
            sendMessageShat(text: text)
        }
        if model?.last?.id == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
                SKStoreReviewController.requestRateApp()
            }
        }
    }
    func errorSendImage() {
        viewModel?.removeLastMessage()
        setupData()
    }
}
