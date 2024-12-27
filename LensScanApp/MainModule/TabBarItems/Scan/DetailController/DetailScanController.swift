//
//  DetailScanController.swift
//  LensScanApp
//
//  Created by Vasiliy Vygnych on 25.11.2024.
//

import UIKit
import SnapKit
import StoreKit

class DetailScanController: UIViewController {
    
    var viewModel: ScanViewModelProtocol?
    var model: SearchResult?
    var searchData: SearchData?
    var factsData: [FactsData]?
    var preview: UIImage?
    private var contentSize: CGSize {
        CGSize(width: view.frame.width,
               height: view.frame.height)
    }
    private let InfoModelLabel = ["Origin".localized(LanguageApp.appLaunguage),
                                  "Weight".localized(LanguageApp.appLaunguage),
                                  "Model".localized(LanguageApp.appLaunguage)] 
    private let infoImage = [UIImage(named: "firstInfoImage"),
                     UIImage(named: "secondInfoImage"),
                     UIImage(named: "threedInfoImage")]
    private var InfoModelTitle: [String] = []
    private var tableHeight = 0
    private var sections: [FactsModelSection] = []
    private let cellIdentifier = "factsCell"
    private var rating: String?

    private var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var favoriteButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 44/2
        view.clipsToBounds = true
        return view
    }()
    private var favoriteButtonImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var shareButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 44/2
        view.clipsToBounds = true
        return view
    }()
    private var shareButtonImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var previewImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
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
    private var resultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
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
        view.font = .systemFont(ofSize: 17,
                                weight: .semibold)
        view.textAlignment = .center
        return view
    }()
    private var infoStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.spacing = 9
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    private var descriptionTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .light)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private var didYouKnowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    private var didYouKnowLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .left
        return view
    }()
    private var didYouKnowTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .light)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    private var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    private var priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .light)
        view.textAlignment = .left
        return view
    }()
    private var priceTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        return view
    }()
    
    private var ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    private var ratingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 14,
                                weight: .light)
        view.textAlignment = .left
        return view
    }()
    private var ratingTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private var factsTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18,
                                weight: .bold)
        view.textAlignment = .left
        return view
    }()
    private var factsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.scrollsToTop = false
        view.isScrollEnabled = false
        view.separatorColor = .clear
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        setupUI()
        setupColor()
        setupText()
        setupImage()
        setupeButton()
        setupConstraints()
        rating = String(format: "%.1f",
                        Double.random(in: 3.5...5.0))
        if model == nil {
            setupeSaveData(model: searchData,
                           facts: factsData)
        } else {
            setupData(model)
        }
        setupeInfoStack()
        setupTableView()
        if viewModel?.getSearchData(true)?.count ?? 0 < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SKStoreReviewController.requestRateApp()
            }
        }
    }
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(previewImage)
        
        scrollView.addSubview(resultView)
        resultView.addSubview(upView)
        resultView.addSubview(headerTitle)
        
        resultView.addSubview(infoStackView)
        resultView.addSubview(descriptionTitle)
        
        resultView.addSubview(didYouKnowView)
        didYouKnowView.addSubview(didYouKnowTitle)
        didYouKnowView.addSubview(didYouKnowLabel)
        
        resultView.addSubview(priceView)
        priceView.addSubview(priceLabel)
        priceView.addSubview(priceTitle)
        
        resultView.addSubview(ratingView)
        ratingView.addSubview(ratingLabel)
        ratingView.addSubview(ratingTitle)
                resultView.addSubview(factsView)
        factsView.addSubview(factsTitle)
        factsView.addSubview(tableView)
    
        view.addSubview(backButton)
        previewImage.addSubview(favoriteButton)
        favoriteButton.addSubview(favoriteButtonImage)
        previewImage.addSubview(shareButton)
        shareButton.addSubview(shareButtonImage)
    }
    private func setupTableView() {
        tableView.rowHeight = 30
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FactsCell.self,
                           forCellReuseIdentifier: cellIdentifier)
    }
    private func setupeSaveData(model: SearchData?,
                                facts: [FactsData]?) {
        headerTitle.text = model?.title
        previewImage.image = UIImage(data: model?.preview ?? Data())
        
        InfoModelTitle.append(model?.origin ?? "")
        InfoModelTitle.append(model?.weight ?? "")
        InfoModelTitle.append(model?.scientificName ?? "")
        
        if facts?.isEmpty == false {
            facts?.forEach { fact in
                let section = FactsModelSection(title: fact.header ?? "",
                                                items: [fact.title ?? ""],
                                                isExpanded: false)
                self.sections.append(section)
            }
        } else {
            factsView.isHidden = true
        }
     
        descriptionTitle.text = model?.titleDescription
        didYouKnowTitle.text = model?.youNow
        
        priceTitle.text = model?.price
        ratingTitle.text = model?.rating
        
        if model?.isVavorite == true {
            favoriteButton.tag = 1
            favoriteButtonImage.image = UIImage(named: "likeOn")
        }
        
        tableHeight = sections.count * 52
        tableView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(tableHeight)
        }
    }
    private func setupData(_ model: SearchResult?) {
        headerTitle.text = model?.gptResult.title
        
        InfoModelTitle.append(model?.gptResult.origin ?? "")
        InfoModelTitle.append(model?.gptResult.weight ?? "")
        InfoModelTitle.append(model?.gptResult.scientificName ?? "")
        
        if model?.gptResult.interestingFacts?.isEmpty == false {
            model?.gptResult.interestingFacts?.forEach({ fact in
                let section = FactsModelSection(title: fact?.heading ?? "",
                                  items: [fact?.text ?? ""],
                                                isExpanded: false)
                self.sections.append(section)
                viewModel?.setFactsData(title: fact?.heading ?? "", //save Fakts
                                        description: fact?.text ?? "")
            })
        } else {
            factsView.isHidden = true
        }
        descriptionTitle.text = model?.gptResult.description
        didYouKnowTitle.text = model?.gptResult.didYouKnow
        
        priceTitle.text = model?.gptResult.price
        ratingTitle.text = rating
        saveSearch(model) // save search
        
        tableHeight = sections.count * 52
        tableView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(tableHeight)
        }
    }
    private func setupeInfoStack() {
        infoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        InfoModelLabel.enumerated().forEach { index, name in
            let view = InfoBuilder()
            view.configure(info: InfoModelTitle[index],
                           label: name,
                           image: infoImage[index])
            infoStackView.addArrangedSubview(view)
        }
    }
    private func saveSearch(_ model: SearchResult?) {
        guard let model else { return }
        let newData = SearchSave(image: preview,
                                 title: model.gptResult.title,
                                 description: model.gptResult.description,
                                 origin: model.gptResult.origin,
                                 weight: model.gptResult.weight,
                                 scientificName: model.gptResult.scientificName,
                                 youNow: model.gptResult.didYouKnow,
                                 price: model.gptResult.price,
                                 rating: rating,
                                 isVavorite: false)
        viewModel?.setSearchData(chatData: newData)
    }
    private func setupText() {
        didYouKnowLabel.text = "Did you know?".localized(LanguageApp.appLaunguage)
        priceLabel.text = "Avg. Price".localized(LanguageApp.appLaunguage)
        ratingLabel.text = "Rating".localized(LanguageApp.appLaunguage)
        factsTitle.text = "Ineresting Facts".localized(LanguageApp.appLaunguage)
    }
    private func dataToShare() -> String {
        var result = String()
        if let data = viewModel?.getSearchData(true)?.last {
            let text =  String(format: "%@: %@, %@: %@, %@: %@, %@, %@",
                               "Origin".localized(LanguageApp.appLaunguage),
                               data.origin,
                               "Weight".localized(LanguageApp.appLaunguage),
                               data.weight,
                               "Model".localized(LanguageApp.appLaunguage),
                               data.scientificName,
                               data.titleDescription,
                               data.youNow)
            result = text
        }
        return result
    }
    private func setupColor() {
        view.backgroundColor = .white
        resultView.backgroundColor = .white
        didYouKnowLabel.textColor = .black
        didYouKnowTitle.textColor = .black
        didYouKnowView.backgroundColor = UIColor(named: "colorWhiteCustom")
        upView.backgroundColor = UIColor(named: "grayCDColor")
        priceView.backgroundColor = UIColor(named: "colorWhiteCustom")
        ratingView.backgroundColor = UIColor(named: "colorWhiteCustom")
        factsView.backgroundColor = UIColor(named: "colorWhiteCustom")
        priceLabel.textColor = .black
        ratingLabel.textColor = .black
        priceTitle.textColor = .black
        ratingTitle.textColor = .black
        factsTitle.textColor = .black
        descriptionTitle.textColor = .black
        
        shareButton.backgroundColor = UIColor(named: "brownCustomColor")
        favoriteButton.backgroundColor = UIColor(named: "brownCustomColor")
    }
    private func setupImage() {
        previewImage.image = preview
        backButton.setBackgroundImage(UIImage(named: "backButtonBlack"),
                                      for: .normal)
        shareButtonImage.image = UIImage(named: "shareScan")
        favoriteButtonImage.image = UIImage(named: "likeOff")
    }
    private func setupeButton() {
        backButton.addTarget(self,
                             action: #selector(popToView),
                             for: .touchUpInside)
        favoriteButton.addTarget(self,
                                 action: #selector(likeScan),
                                 for: .touchUpInside)
        shareButton.addTarget(self,
                              action: #selector(shareScan),
                              for: .touchUpInside)
    }
    @objc func popToView() {
        navigationController?.popViewController(animated: true)
    }
    @objc func likeScan(_ sender: UIButton) {
        viewModel?.viewAnimate(view: favoriteButton,
                               duration: 0.2,
                               scale: 0.96)
        sender.tag += 1
        switch sender.tag {
        case 1:
            addFavorites(true)
            favoriteButtonImage.image = UIImage(named: "likeOn")
        case 2:
            addFavorites(false)
            favoriteButtonImage.image = UIImage(named: "likeOff")
            sender.tag = 0
        default:
            break
        }
    }
    private func addFavorites(_ bool: Bool) {
        let data = viewModel?.getSearchData(true)?.last
        viewModel?.editFavorite(bool,
                                id: data?.id)
    }
    @objc func shareScan() {
        viewModel?.viewAnimate(view: shareButton,
                               duration: 0.2,
                               scale: 0.96)
        let vc = UIActivityViewController(activityItems: [dataToShare()],
                                          applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = shareButtonImage
        present(vc,
                animated: true)
    }
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.topMargin.equalTo(15)
            make.left.equalTo(15)
            make.width.height.equalTo(44)
        }
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.right.equalTo(previewImage.snp.right).inset(20)
            make.width.height.equalTo(44)
        }
        favoriteButtonImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(20)
        }
        shareButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(70)
            make.right.equalTo(favoriteButton.snp.left).inset(-15)
            make.width.height.equalTo(44)
        }
        shareButtonImage.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        previewImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-50)
            make.width.equalToSuperview()
            make.height.equalTo(340)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        resultView.snp.makeConstraints { make in
            make.top.equalTo(previewImage.snp.bottom).inset(30)
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
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.width.equalToSuperview()
            make.height.equalTo(25)
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(headerTitle.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.height.equalTo(160)
        }
        descriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(15)
            make.width.equalToSuperview().inset(40)
            make.left.equalTo(40)
            make.height.greaterThanOrEqualTo(20)
        }
        didYouKnowView.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitle.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        didYouKnowLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        didYouKnowTitle.snp.makeConstraints { make in
            make.top.equalTo(didYouKnowLabel.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
        }
    
        priceView.snp.makeConstraints { make in
            make.top.equalTo(didYouKnowView.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.height.equalTo(90)
            make.right.equalTo(didYouKnowView.snp.centerX).offset(-10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        priceTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(didYouKnowView.snp.bottom).offset(20)
            make.right.equalTo(didYouKnowView.snp.right)
            make.height.equalTo(90)
            make.left.equalTo(didYouKnowView.snp.centerX).offset(10)
        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        ratingTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalToSuperview().inset(20)
        }
        factsView.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(resultView.snp.right).inset(20)
            make.bottom.equalToSuperview()
        }
        factsTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(factsTitle.snp.bottom)
            make.left.equalTo(20)
            make.width.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(tableHeight)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
extension DetailScanController: UITableViewDelegate,
                                    UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                      for: indexPath) as? FactsCell else { return UITableViewCell() }
        let text = sections[indexPath.section].items[indexPath.row]
        cell.configureCell(text)
        cell.isUserInteractionEnabled = false
        return cell
    }
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        let label = UILabel()
        label.textColor = .black
        label.text = sections[section].title
        label.font = .systemFont(ofSize: 14,
                                 weight: .semibold)
        header.addSubview(label)
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "arrowImageDown")
        header.addSubview(image)
        header.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                           action: #selector(handleExpandCloseSection)))
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        image.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        if sections[section].isExpanded == true {
            image.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                image.isHidden = false
            }
            image.transform = CGAffineTransform(rotationAngle: .pi)
        } else {
            image.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                image.isHidden = false
            }
            image.transform = CGAffineTransform(rotationAngle: .pi*2)
        }
        header.tag = section
        return header
    }
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    @objc private func handleExpandCloseSection(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        sections[section].isExpanded.toggle()
        if sections[section].isExpanded == true {
            tableView.snp.updateConstraints { make in
                tableHeight += sections[section].items.count * 30
                make.height.greaterThanOrEqualTo(tableHeight)
            }
        } else {
            tableView.snp.updateConstraints { make in
                tableHeight -= sections[section].items.count * 30
                make.height.greaterThanOrEqualTo(tableHeight)
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        tableView.reloadSections([section],
                                 with: .automatic)
    }
}
