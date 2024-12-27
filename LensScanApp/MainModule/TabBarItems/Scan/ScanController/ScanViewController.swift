//
//  ScanViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import SnapKit
import AVFoundation
import PhotosUI

class ScanViewController: UIViewController {
    
    weak var imageDelegate: CropPhotoDelegate?
    private var loaderView = LoaderView()
    var viewModel: ScanViewModelProtocol?
    var searchType = SearchType.anything
    
    private var session: AVCaptureSession?
    private let output = AVCapturePhotoOutput()
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    private var lightIsOn = false
    private var selectPhoto: UIImage?
    
    private var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var photoButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var flashButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var galagyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        setupUI()
        setupText()
        setupColor()
        setupImage()
        setupConstraints()
        setupeButton()
        searchType(searchType)
        viewModel?.mainDelegate = self
        checkPermission()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        DispatchQueue.global().async { [weak self] in
            self?.session?.startRunning()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.frame
    }
    private func searchType(_ type: SearchType) {
        switch type {
        case .pets:
            print("searchType: pets")
        case .coin:
            print("searchType: coin")
        case .plant:
            print("searchType: plant")
        case .food:
            print("searchType: food")
        case .devices:
            print("searchType: devices")
        case .interior:
            print("searchType: interior")
        case .architecture:
            print("searchType: architecture")
        case .cars:
            print("searchType: cars")
        case .seashells:
            print("searchType: seashells")
        case .paintings:
            print("searchType: paintings")
        case .anything:
            print("searchType: anything")
        case .chatAI:
            print("chatAI")
        }
    }
    private func setupUI() {
        view.addSubview(backButton)
        
        view.addSubview(galagyButton)
        view.addSubview(photoButton)
        view.addSubview(flashButton)
        
        view.addSubview(loaderView)
        loaderView.isHidden = true
        
        view.addSubview(infoView)
        infoView.addSubview(infoViewTitle)
    }
    private func setupText() {
        infoViewTitle.text = "Add an image to the request".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .black
        infoViewTitle.textColor = .white
    }
    private func setupImage() {
        backButton.setBackgroundImage(UIImage(named: "backButton"),
                                      for: .normal)
        photoButton.setBackgroundImage(UIImage(named: "photoImage"),
                                       for: .normal)
        flashButton.setBackgroundImage(UIImage(named: "flashImageOff"),
                                       for: .normal)
        galagyButton.setBackgroundImage(UIImage(named: "galagyImage"),
                                        for: .normal)
        infoView.image = UIImage(named: "infoImageView")
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        photoButton.addTarget(self,
                              action: #selector(takePhoto),
                              for: .touchUpInside)
        flashButton.addTarget(self,
                              action: #selector(flashOnOrOff),
                              for: .touchUpInside)
        galagyButton.addTarget(self,
                               action: #selector(openGalagy),
                               for: .touchUpInside)
    }
    @objc func openGalagy() {
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
        if searchType == .anything {
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 0
                tabBarController.tabBar.isHidden = false
            }
        }
    }
    @objc func takePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(),
                            delegate: self)
    }
    private func startScanLoder() {
        loaderView.alpha = 1
        infoView.isHidden = true
        loaderView.startAnimatingDots()
        loaderView.isHidden = false
    }
    private func stopScanLoder() {
        UIView.animate(withDuration: 0.2,
                       animations: { [weak self] in
            self?.loaderView.alpha = 0
        }, completion: { finished in
            self.loaderView.isHidden = true
            self.loaderView.stopAnimatingDots()
        })
    }
    
    @objc func flashOnOrOff(_ sender: UIButton) {
        if let device = AVCaptureDevice.default(for: .video), device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = lightIsOn ? .off : .on
                device.unlockForConfiguration()
                lightIsOn.toggle()
                switch device.torchMode {
                case .off:
                    flashButton.setBackgroundImage(UIImage(named: "flashImageOff"),
                                                   for: .normal)
                case .on:
                    flashButton.setBackgroundImage(UIImage(named: "flashImageOn"),
                                                   for: .normal)
                case .auto:
                    break
                @unknown default:
                    break
                }
            } catch {
                print("Error toggling torch: \(error)")
            }
        } else {
            print("Torch is not available")
        }
    }
    deinit {
        session?.stopRunning()
    }
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(30)
        }
        
        galagyButton.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.centerY.equalTo(photoButton.snp.centerY)
            make.width.height.equalTo(46)
        }
        photoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(35)
            make.width.height.equalTo(85)
        }
        flashButton.snp.makeConstraints { make in
            make.right.equalTo(-30)
            make.centerY.equalTo(photoButton.snp.centerY)
            make.width.height.equalTo(46)
        }
        loaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(70)
            make.bottom.equalTo(photoButton.snp.top).inset(-15)
        }
        infoViewTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
extension ScanViewController: AVCapturePhotoCaptureDelegate {
    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.setupCamera()
                    }
                } else {
                    print("Доступ к камере был отклонен")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        case .restricted, .denied:
            DispatchQueue.main.async {
                self.accessPermission()
            }
        case .authorized:
            DispatchQueue.main.async {
                self.setupCamera()
            }
        @unknown default:
            break
        }
    }
    private func accessPermission() {
         var actions: [UIAlertAction] = []
         let openSetting = UIAlertAction(title: "Open Settings".localized(LanguageApp.appLaunguage),
                                         style: .default) { _ in
             if let url = URL(string: UIApplication.openSettingsURLString) {
                 UIApplication.shared.open(url,
                                           options: [:],
                                           completionHandler: nil)
             }
         }
         actions.append(openSetting)
         let cancel = UIAlertAction(title: "Cancel".localized(LanguageApp.appLaunguage),
                                    style: .destructive)
         actions.append(cancel)
         if let errorAlert = viewModel?.showAlert(title: "Access to the camera is closed".localized(LanguageApp.appLaunguage),
                                                  message: "to open access, go to settings".localized(LanguageApp.appLaunguage),
                                                  actions: actions) {
             present(errorAlert,
                     animated: true)
         }
     }
    private func setupCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                self.session = session
                self.session?.startRunning()
            } catch {
                print(error)
            }
        }
    }
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: (any Error)?) {
        guard let photoData = photo.fileDataRepresentation(),
              let image = UIImage(data: photoData) else { return }
        selectPhoto = image
        viewModel?.openCropController(delegate: self,
                                      photo: image)
        session?.stopRunning()
    }
}
extension ScanViewController: PHPickerViewControllerDelegate {
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
                        }
                    }
                }
            }
        }
    }
}
extension ScanViewController: CropPhotoDelegate {
    func didSelectPhoto(_ photo: UIImage?) {
        if searchType == .chatAI {
            imageDelegate?.didSelectPhoto(photo)
            navigationController?.popToRootViewController(animated: false)
        } else {
            startScanLoder()
            if let image = photo {
                viewModel?.getSearchResults(image)
            }
            
            
        }
    }
}
extension ScanViewController: ScnanMainViewDelegate {
    func successfulSearchResult(_ model: SearchResult) {
        session?.stopRunning()
        stopScanLoder()
        viewModel?.openResultScanController(photo: selectPhoto,
                                            model: model)
    }
    func unsuccessfulSearchResult() {
        stopScanLoder()
        if let alert = viewModel?.showAlert(title: "Something went wrong".localized(LanguageApp.appLaunguage),
                                            message: "Please try again later".localized(LanguageApp.appLaunguage),
                                            actions: [UIAlertAction(title: "Ok",
                                                                    style: .default)]) {
            present(alert,
                    animated: true)
        }
    }
}
