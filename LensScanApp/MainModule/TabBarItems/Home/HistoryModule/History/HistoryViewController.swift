//
//  HistoryViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 19.11.2024.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    private var cellIdentifier = "historyCell"
    var model: [SearchData]? {
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
    
    private var favoriteButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var emptyModelImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    private var emptyTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .center
        return view
    }()
    private var emptySubtitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .light)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var scanButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        return view
    }()
    private var scanTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16,
                                weight: .bold)
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        setupUI()
        setuteTableView()
        setupText()
        setupColor()
        setupImage()
        setupeButton()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model = viewModel?.getSearchData(true)
    }
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(headerTitle)
        
        view.addSubview(favoriteButton)
        
        view.addSubview(tableView)
        
        view.addSubview(emptyModelImage)
        view.addSubview(emptyTitle)
        view.addSubview(emptySubtitle)
        view.addSubview(scanButton)
        scanButton.addSubview(scanTitle)
    }
    private func hideInfo() {
        emptyModelImage.isHidden = true
        emptyTitle.isHidden = true
        emptySubtitle.isHidden = true
        scanButton.isHidden = true
    }
    private func setuteTableView() {
        tableView.register(HistoryCell.self,
                    forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.rowHeight = 100
    }
    private func setupText() {
        headerTitle.text = "History".localized(LanguageApp.appLaunguage)
        emptyTitle.text = "It’s empty here".localized(LanguageApp.appLaunguage)
        emptySubtitle.text = "Feel this space with your scans!".localized(LanguageApp.appLaunguage)
        scanTitle.text = "Start Scan".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .white
        headerTitle.textColor = .black
        emptyTitle.textColor = .black
        emptySubtitle.textColor = UIColor(named: "grayColorView")
        scanButton.backgroundColor = UIColor(named: "customBlueColor")
        scanButton.setTitleColor(.white,
                                 for: .normal)
        tableView.backgroundColor = .white
        scanTitle.textColor = .white
    }
    private func setupImage() {
        backButton.setBackgroundImage(UIImage(named: "arrowLeft"),
                                      for: .normal)
        favoriteButton.setBackgroundImage(UIImage(named: "favoriteImageOff"),
                                          for: .normal)
        emptyModelImage.image = UIImage(named: "emptyImage")
        
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        favoriteButton.addTarget(self,
                                 action: #selector(openFavorite),
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
    @objc func openFavorite() {
        viewModel?.openFavoriteViewController()
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: true)
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
        favoriteButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.right.equalTo(-15)
            make.width.height.equalTo(24)
        }
        emptyModelImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(133)
            make.top.equalTo(headerTitle.snp.bottom).offset(150)
        }
        emptyTitle.snp.makeConstraints { make in
            make.top.equalTo(emptyModelImage.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        emptySubtitle.snp.makeConstraints { make in
            make.top.equalTo(emptyTitle.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(17)
        }
        scanButton.snp.makeConstraints { make in
            make.top.equalTo(emptySubtitle.snp.bottom).offset(20)
            make.height.equalTo(54)
            make.centerX.equalToSuperview()
        }
        scanTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(30)
        }
    }
}
extension HistoryViewController: UITableViewDataSource,
                                    UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? HistoryCell,
              let model = model?[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(model)
        cell.model = model
        cell.viewModel = viewModel
        hideInfo()
        return cell
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let model = model?[indexPath.row]
            viewModel?.viewAnimate(view: cell,
                                   duration: 0.2,
                                   scale: 0.98)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
              
                
//                let facts = self?.viewModel?.getFactsData(true)
//                print(facts?[indexPath.row].id)
                
                let facts = self?.viewModel?.fetchFacts(with: Int( model?.id ?? 0))
                self?.viewModel?.openDetailScanController(searchData: model,
                                                          factsData: facts)
                
            }
        }
    }
}
