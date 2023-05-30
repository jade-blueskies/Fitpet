//
//  ForecastView.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class ForecastView: UIView {
    private static let listSectionHeaderViewReuseId = "listSectionHeaderView"
    private static let listCellReuseId = "listCell"
    
    private let disposeBag = DisposeBag()
    private let listView = UITableView(frame: .zero, style: .grouped)
    private let retryButton = UIButton()
    
    private var listModel = [Section]()
    typealias Section = Forecast.DailyForecasts.ViewModel.Section
    
    let listRequestTrigger = PublishRelay<Void>()
    let listRefreshTrigger = PublishRelay<Void>()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
        self.bindWithInteractions()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureViews()
        self.bindWithInteractions()
    }
    
}



// MARK: - Interface
extension ForecastView {
    
    func displayListModel(_ listModel: [Section]) {
        self.listModel = listModel
        self.listView.reloadData()
        self.listView.refreshControl?.endRefreshing()
        self.listView.isHidden = false
        self.retryButton.isHidden = true
    }
    
    func displayListLoadingFailure() {
        self.listView.refreshControl?.endRefreshing()
        self.listView.isHidden = true
        self.retryButton.isHidden = false
    }
    
}



// MARK: - Logic
extension ForecastView {
    
    private func bindWithInteractions() {
        self.retryButton.rx.tap
            .do(onNext: { [weak self] in
                self?.retryButton.isHidden = true
            })
            .bind(to: self.listRequestTrigger)
            .disposed(by: self.disposeBag)
                
        self.listView.refreshControl?.rx.controlEvent(.valueChanged)
            .bind(to: self.listRefreshTrigger)
            .disposed(by: self.disposeBag)
    }
    
}



// MARK: - Views
extension ForecastView {
    
    private func configureViews() {
        self.backgroundColor = .systemBackground
        
        self.listView.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            $0.register(ForecastListSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: Self.listSectionHeaderViewReuseId)
            $0.register(ForecastListCell.self, forCellReuseIdentifier: Self.listCellReuseId)
            $0.dataSource = self
            $0.delegate = self
            $0.allowsSelection = false
            $0.refreshControl = UIRefreshControl()
        }
        
        self.retryButton.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.height.equalTo(50)
                $0.center.equalTo(self.safeAreaLayoutGuide)
            }
            $0.setImage(UIImage(systemName: "arrow.clockwise.circle.fill"), for: .normal)
            $0.contentVerticalAlignment = .fill
            $0.contentHorizontalAlignment = .fill
        }
        
        self.listView.isHidden = true
        self.retryButton.isHidden = true
    }
    
}



// MARK: - UITableViewDataSource
extension ForecastView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listModel[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.listCellReuseId, for: indexPath)
        guard let cell = cell as? ForecastListCell else { return cell }
        let model = self.listModel[indexPath.section].rows[indexPath.row]
        cell.displayModel(model)
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension ForecastView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.listSectionHeaderViewReuseId)
        
        guard let view = view as? ForecastListSectionHeaderView else { return view }
        let locationName = self.listModel[section].locationName
        view.displayLocationName(locationName)
        return view
    }
    
}
