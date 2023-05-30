//
//  ForecastListSectionHeaderView.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/29.
//

import UIKit
import Then
import SnapKit

final class ForecastListSectionHeaderView: UITableViewHeaderFooterView {
    
    private let locationLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureViews()
    }
    
}



// MARK: - Interface
extension ForecastListSectionHeaderView {
    
    func displayLocationName(_ locationName: String) {
        self.locationLabel.text = locationName
    }
    
}



// MARK: - Views
extension ForecastListSectionHeaderView {
    
    private func configureViews() {
        self.locationLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.left.right.equalTo(self.contentView.layoutMarginsGuide)
                $0.top.bottom.equalToSuperview().inset(10)
                $0.height.equalTo(30)
            }
            $0.font = .systemFont(ofSize: 22, weight: .bold)
        }
    }
    
}
