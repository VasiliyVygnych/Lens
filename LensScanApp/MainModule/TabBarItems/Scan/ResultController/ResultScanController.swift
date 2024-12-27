//
//  ResultScanController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 25.11.2024.
//

import UIKit
import SnapKit
import SafariServices

class ResultScanController: UIViewController  {
    
    var viewModel: ScanViewModelProtocol?
    private var cellIdentifier = "resultCell"
    private var contentSize: CGSize {
        CGSize(width: view.frame.width,
               height: view.frame.height)
    }
    var preview: UIImage?
    var model: SearchResult? {
        didSet {
            collectionView.reloadData()
        }
    }

    private var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var previewImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.contentSize = contentSize
        return view
    }()
    
    private var resultButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        return view
    }()
    private var resultTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .center
        return view
    }()
    private var resultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var upView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        return view
    }()
    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20,
                                weight: .bold)
        view.textAlignment = .left
        return view
    }()
    private var headerSubtitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15,
                                weight: .light)
        view.textAlignment = .left
        return view
    }()
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 170,
                                height: 190)
        layout.sectionInset = .init(top: 10,
                                    left: 20,
                                    bottom: 10,
                                    right: 20)
        return layout
    }()
    lazy var collectionView: UICollectionView = {
       let view = UICollectionView(frame: .zero,
                                             collectionViewLayout: self.layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.showsVerticalScrollIndicator = false
        view.register(ResultCell.self,
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
        setupeData(model)
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(previewImage)
        
        scrollView.addSubview(resultButton)
        resultButton.addSubview(resultTitle)
        
        scrollView.addSubview(resultView)
        resultView.addSubview(upView)
        
        resultView.addSubview(headerTitle)
        resultView.addSubview(headerSubtitle)
        
        resultView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(backButton)
    }
    private func setupeData(_ model: SearchResult?) {
        headerTitle.text = model?.gptResult.title
        headerSubtitle.text = model?.gptResult.label.first
    }
    private func setupText() {
        resultTitle.text = "Scan Results".localized(LanguageApp.appLaunguage)
    }
    private func setupColor() {
        view.backgroundColor = .white
        headerTitle.textColor = .black
        headerSubtitle.textColor = .black
        resultView.backgroundColor = .white
        collectionView.backgroundColor = .clear
        resultButton.backgroundColor = UIColor(named: "customBlueColor")
        resultTitle.textColor = .white
        upView.backgroundColor = UIColor(named: "grayCDColor")
    }
    private func setupImage() {
        previewImage.image = preview
        previewImage.backgroundColor = .green
        backButton.setBackgroundImage(UIImage(named: "backButton"),
                                      for: .normal)
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        resultButton.addTarget(self,
                               action: #selector(openDetail),
                               for: .touchUpInside)
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: true)
    }
    @objc func openDetail() {
        viewModel?.viewAnimate(view: resultButton,
                               duration: 0.2,
                               scale: 0.96)
        viewModel?.openDetailScanController(model: model,
                                            photo: preview)
    }
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(30)
        }
        previewImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-65)
            make.width.equalToSuperview()
            make.height.equalTo(500)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        resultButton.snp.makeConstraints { make in
            make.bottom.equalTo(resultView.snp.top).inset(-30)
            make.height.equalTo(54)
            make.centerX.equalToSuperview()
        }
        resultTitle.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        resultView.snp.makeConstraints { make in
            make.top.equalTo(previewImage.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        upView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(40)
            make.height.equalTo(5)
            make.centerX.equalToSuperview()
        }
        headerTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(25)
            make.width.equalToSuperview().inset(20)
        }
        headerSubtitle.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(5)
            make.left.equalTo(20)
            make.height.equalTo(17)
            make.width.equalToSuperview().inset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerSubtitle.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(600)
            make.bottom.equalToSuperview().inset(-60)
        }
    }
}
extension ResultScanController: UICollectionViewDataSource,
                            UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        model?.itemResult.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? ResultCell,
              let data = model?.itemResult[indexPath.item] else { return UICollectionViewCell() }
        cell.configureData(data)
        cell.viewModel = viewModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let collectionView = self.collectionView.cellForItem(at: indexPath) {
            let model = model?.itemResult[indexPath.item]
            viewModel?.viewAnimate(view: collectionView,
                                   duration: 0.2,
                                   scale: 0.96)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) { [weak self] in
                if let urlString = model?.link {
                    self?.openLink(urlString: urlString)
                }
            }
        }
    }
    func openLink(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC,
                animated: true)
    }
}
extension ResultScanController: UIScrollViewDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
