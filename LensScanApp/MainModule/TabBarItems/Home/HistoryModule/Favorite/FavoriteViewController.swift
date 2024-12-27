//
//  FavoriteViewController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 20.11.2024.
//

import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol?
    private var cellIdentifier = "favouritesCell"
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
        model = viewModel?.fetchFavorite(with: true)
    }
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(headerTitle)
        view.addSubview(tableView)
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
        headerTitle.text = "Favourites".localized(LanguageApp.appLaunguage)
        
        
    }
    private func setupColor() {
        view.backgroundColor = .white
        headerTitle.textColor = .black
        tableView.backgroundColor = .white
    }
    private func setupImage() {
        backButton.setBackgroundImage(UIImage(named: "arrowLeft"),
                                      for: .normal)
        
        
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
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
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.bottomMargin.equalToSuperview().inset(30)
        }
    }
}
extension FavoriteViewController: UITableViewDataSource,
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
        cell.favoriteButton.tag = 1
        cell.viewModel = viewModel
        cell.delegate = self
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
                let facts = self?.viewModel?.fetchFacts(with: Int( model?.id ?? 0))
                self?.viewModel?.openDetailScanController(searchData: model,
                                                          factsData: facts)
            }
        }
    }
}
extension FavoriteViewController: HistoryCellDelegate {
    func reloadData() {
        model = viewModel?.fetchFavorite(with: true)
    }
}
