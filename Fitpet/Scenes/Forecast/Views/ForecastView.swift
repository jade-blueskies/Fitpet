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
    private static let listCellReuseId = "listCell"
    
    private let listView = UITableView()
    private var listModel = [Forecast]()
    
    
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
    
}



// MARK: - Logic
extension ForecastView {
    
    private func bindWithInteractions() {
        
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
            $0.register(ForecastListCell.self, forCellReuseIdentifier: Self.listCellReuseId)
        }
    }
    
}



// MARK: - UITableViewDataSource
extension ForecastView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
