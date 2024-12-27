//
//  CropController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 22.11.2024.
//

import UIKit
import SnapKit

class CropController: UIViewController {
    
    var viewModel: ScanViewModelProtocol?
    var photo: UIImage?
    weak var delegate: CropPhotoDelegate?
    private let pinchGesture = UIPinchGestureRecognizer()
    private let panGesture = UIPanGestureRecognizer()
    private var currentScale: CGFloat = 1.0
    private let minScale: CGFloat = 0.2
    private let maxScale: CGFloat = 5.0
    
    private var cropView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
//        view.backgroundColor = .red
//        view.alpha = 0.5
        return view
    }()
    private var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var selectPhoto: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    private var frameImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        return view
    }()
    private var attachButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    private var attachButtonTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .center
        return view
    }()
    private var infoView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleToFill
        return view
    }()
    private var infoViewTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .medium)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        setupText()
        setupColor()
        setupImage()
        setupeButton()
        setupConstraints()
    }
    private func setupUI() {
        view.addSubview(selectPhoto)
        view.addSubview(frameImage)
        view.addSubview(attachButton)
        view.addSubview(backButton)
        attachButton.addSubview(attachButtonTitle)
        
        view.addSubview(cropView)

        view.addSubview(infoView)
        infoView.addSubview(infoViewTitle)
    }
    private func setupText() {
        attachButtonTitle.text = "Attach".localized(LanguageApp.appLaunguage)
        infoViewTitle.text = "Adjust the area to fit the item you want to analyze".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .black
        attachButton.backgroundColor = UIColor(named: "customBlueColor")
        attachButtonTitle.textColor = .white
        infoViewTitle.textColor = .white
    }
    private func setupImage() {
        selectPhoto.image = photo
        backButton.setBackgroundImage(UIImage(named: "backButton"),
                                      for: .normal)
        frameImage.image = UIImage(named: "frameImage")
        infoView.image = UIImage(named: "infoImageView")
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        attachButton.addTarget(self,
                               action: #selector(attachPhoto),
                               for: .touchUpInside)
        pinchGesture.addTarget(self,
                               action: #selector(zoomImage))
        frameImage.addGestureRecognizer(pinchGesture)
        panGesture.addTarget(self,
                             action: #selector(scrollImage))
        frameImage.addGestureRecognizer(panGesture)
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: false)
    }
    @objc func attachPhoto() {
        view.layoutIfNeeded()
        view.layoutMarginsDidChange()
        viewModel?.viewAnimate(view: attachButton,
                               duration: 0.2,
                               scale: 0.97)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) { [weak self] in
            guard let self else { return }
            if let croppedImage = cropImageToView() {
                delegate?.didSelectPhoto(croppedImage)
            }
            navigationController?.popToRootViewController(animated: false)
        }
    }
    
    func cropImageToView() -> UIImage? {
        let visibleRect = cropView.convert(cropView.bounds,
                                           to: selectPhoto)
        
        
        let renderer = UIGraphicsImageRenderer(bounds: visibleRect)
        return renderer.image { _ in
            selectPhoto.drawHierarchy(in: selectPhoto.bounds,
                                      afterScreenUpdates: true)
        }
    }
    
    
    
    
    
    
    
    
    @objc func scrollImage(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: selectPhoto)
        if gesture.state == .began || gesture.state == .changed {
            selectPhoto.center = CGPoint(x: selectPhoto.center.x + translation.x,
                                         y: selectPhoto.center.y + translation.y)
            gesture.setTranslation(.zero,
                                   in: selectPhoto)
        }
        selectPhoto.layoutIfNeeded()
    }
    @objc func zoomImage(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            let newScale = currentScale * gesture.scale
                if newScale < minScale {
                    gesture.scale = minScale / currentScale
                } else if newScale > maxScale {
                    gesture.scale = maxScale / currentScale
                } else {
                    selectPhoto.transform = selectPhoto.transform.scaledBy(x: gesture.scale,
                                                                           y: gesture.scale)
                currentScale = newScale
                gesture.scale = 1.0
            }
        }
        selectPhoto.layoutIfNeeded()
    }
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(44)
        }
        frameImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectPhoto.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.centerY.centerX.equalToSuperview()
        }
        
        attachButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview().inset(40)
        }
        attachButtonTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.height.equalTo(20)
        }
        cropView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(45)
            make.height.equalTo(305)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
        infoView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(70)
            make.bottom.equalTo(attachButton.snp.top).inset(-15)
        }
        infoViewTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
