//
//  HomeViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 18.11.2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    private var cellIdentifier = "popularCell"
    private var contentSize: CGSize {
        CGSize(width: view.frame.width,
               height: view.frame.height)
    }
    
    private var upView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var logoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    private var historyButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var settingsButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.backgroundColor = .clear
        view.contentSize = contentSize
        return view
    }()
    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 32,
                                weight: .semibold)
        view.textAlignment = .left
        return view
    }()
    
    private var chatButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var chatTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20,
                                weight: .medium)
        view.textAlignment = .left
        return view
    }()
    private var subscribeBannerImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.isUserInteractionEnabled = true
        return view
    }()
    private var subscribeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    private var subscribeTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .bold)
        view.textAlignment = .center
        return view
    }()
    private var subscribeBannerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    private var scanBannerImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.isUserInteractionEnabled = true
        return view
    }()
    private var scanButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    private var scanTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .bold)
        view.textAlignment = .center
        return view
    }()
    private var scanBannerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    
    private var popularTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .left
        return view
    }()
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    lazy var collectionView: UICollectionView = {
       let view = UICollectionView(frame: .zero,
                                             collectionViewLayout: self.layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(PopularCell.self,
                      forCellWithReuseIdentifier: cellIdentifier)
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
//        viewModel?.removeSearchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    private func setupUI() {
        view.addSubview(upView)
        upView.addSubview(logoImage)
        
        view.addSubview(scrollView)
        scrollView.addSubview(headerTitle)
        scrollView.addSubview(chatButton)
        chatButton.addSubview(chatTitle)
        
        scrollView.addSubview(subscribeBannerImage)
        subscribeBannerImage.addSubview(subscribeButton)
        subscribeButton.addSubview(subscribeTitle)
        subscribeBannerImage.addSubview(subscribeBannerTitle)
        
        scrollView.addSubview(scanBannerImage)
        scanBannerImage.addSubview(scanButton)
        scanButton.addSubview(scanTitle)
        scanBannerImage.addSubview(scanBannerTitle)
        
        scrollView.addSubview(popularTitle)
        scrollView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    private func setupText() {
        headerTitle.text = getHeaderTitle()
        
        chatTitle.text = "Write a request".localized(LanguageApp.appLaunguage)
        subscribeTitle.text = "Try Free".localized(LanguageApp.appLaunguage)
        
        subscribeBannerTitle.text = "Get Full Access to Lens Photo".localized(LanguageApp.appLaunguage)
        scanBannerTitle.text = "Scan objects around".localized(LanguageApp.appLaunguage)
        scanTitle.text = "Start Scan".localized(LanguageApp.appLaunguage)
        
        popularTitle.text = "Popular".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .white
        upView.backgroundColor = .white
        headerTitle.textColor = .black
        
        upView.addSubview(historyButton)
        upView.addSubview(settingsButton)
        chatTitle.textColor = UIColor(named: "grayCustomColor")
        
        subscribeButton.backgroundColor = UIColor(named: "customBlueColor")
        subscribeTitle.textColor = .white
        subscribeBannerTitle.textColor = .black
        
        scanButton.backgroundColor = UIColor(named: "customGreenColor")
        scanTitle.textColor = .white
        scanBannerTitle.textColor = .black
        popularTitle.textColor = .black
    }
    private func setupImage() {
        logoImage.image = UIImage(named: "logoImage")
        historyButton.setBackgroundImage(UIImage(named: "historyImage"),
                                         for: .normal)
        settingsButton.setBackgroundImage(UIImage(named: "settingsImage"),
                                          for: .normal)
        chatButton.setBackgroundImage(UIImage(named: "openChanButton"),
                                      for: .normal)
        subscribeBannerImage.image = UIImage(named: "subscribeBanner")
        scanBannerImage.image = UIImage(named: "scanBanner")
        
        
    }
    private func setupeButton() {
        historyButton.addTarget(self,
                                action: #selector(openHistory),
                                for: .touchUpInside)
        settingsButton.addTarget(self,
                                action: #selector(openSettings),
                                for: .touchUpInside)
        chatButton.addTarget(self,
                             action: #selector(openChat),
                             for: .touchUpInside)
        subscribeButton.addTarget(self,
                                  action: #selector(openPayWall),
                                  for: .touchUpInside)
        scanButton.addTarget(self,
                             action: #selector(openScan),
                             for: .touchUpInside)
        
    }
    @objc func openScan() {
        viewModel?.viewAnimate(view: scanButton,
                               duration: 0.2,
                               scale: 0.97)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.tabBarController?.tabBar.isHidden = true
            if let tabBarController = self?.tabBarController {
                tabBarController.selectedIndex = 1
            }
        }
     }
    @objc func openPayWall() {
        viewModel?.viewAnimate(view: subscribeButton,
                               duration: 0.2,
                               scale: 0.97)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.viewModel?.openPayWallController()
        }
     }
   @objc func openHistory() {
       viewModel?.openHistoryViewController()
    }
    @objc func openSettings() {
        viewModel?.openSettingsViewController()
    }
    @objc func openChat() {
        viewModel?.viewAnimate(view: chatButton,
                               duration: 0.2,
                               scale: 0.97)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            if let tabBarController = self?.tabBarController {
                tabBarController.selectedIndex = 2
            }
        }
    }
    func getHeaderTitle() -> String {
        let hour = Calendar.current.component(.hour,
                                              from: Date())
        switch hour {
        case 6..<12:
            return "Good morning!".localized(LanguageApp.appLaunguage)
        case 12..<17:
            return "Good afternoon!".localized(LanguageApp.appLaunguage)
        default:
            return "Good evening!".localized(LanguageApp.appLaunguage)
        }
    }
    private func setupConstraints() {
        upView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
        }
        logoImage.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        historyButton.snp.makeConstraints { make in
            make.centerY.equalTo(logoImage.snp.centerY)
            make.width.height.equalTo(24)
            make.left.equalTo(20)
        }
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalTo(logoImage.snp.centerY)
            make.width.height.equalTo(24)
            make.right.equalTo(-20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(upView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottomMargin.equalToSuperview()
        }
        headerTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(35)
        }
        chatButton.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.left.equalTo(25)
            make.width.equalToSuperview().inset(25)
            make.height.equalTo(70)
        }
        chatTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(70)
            make.right.equalTo(-45)
            make.height.equalTo(20)
        }
        
        subscribeBannerImage.snp.makeConstraints { make in
            make.top.equalTo(chatButton.snp.bottom)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
        subscribeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(15)
            make.right.equalTo(-15)
        }
        subscribeTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        subscribeBannerTitle.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.height.equalTo(70)
            make.right.equalTo(subscribeBannerImage.snp.centerX).offset(-40)
            make.bottom.equalToSuperview().inset(20)
        }
        
        scanBannerImage.snp.makeConstraints { make in
            make.top.equalTo(subscribeBannerImage.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        scanButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(15)
            make.right.equalTo(-15)
        }
        scanTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        scanBannerTitle.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.height.greaterThanOrEqualTo(20)
            make.right.equalTo(scanBannerImage.snp.centerX).offset(-5)
            make.bottom.equalToSuperview().inset(20)
        }
        
        popularTitle.snp.makeConstraints { make in
            make.top.equalTo(scanBannerImage.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(popularTitle.snp.bottom)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(1000)
            make.bottomMargin.equalToSuperview().inset(10)
        }
    }
}
extension HomeViewController: UICollectionViewDataSource,
                              UICollectionViewDelegate,
                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        popularModel.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? PopularCell else { return UICollectionViewCell() }
        let model = popularModel[indexPath.item]
        cell.configureData(model)
        cell.viewModel = viewModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let collectionView = self.collectionView.cellForItem(at: indexPath) {
            let model = popularModel[indexPath.item]
            viewModel?.viewAnimate(view: collectionView,
                                   duration: 0.2,
                                   scale: 0.96)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) { [weak self] in
                self?.tabBarController?.tabBar.isHidden = true
                self?.viewModel?.openScanController(searchType: model.type)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 2
        return CGSize(width: width,
                      height: 185)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10,
                            left: 0,
                            bottom: 10,
                            right: 0)
    }
}
