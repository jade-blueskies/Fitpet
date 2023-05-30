//
//  ForecastListCell.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/29.
//

import UIKit
import Then
import SnapKit

final class ForecastListCell: UITableViewCell {
    
    private let dateLabel = UILabel()
    private let weatherIconView = UIImageView()
    private let weatherDescriptionLabel = UILabel()
    private let maximumTemperatureLabel = UILabel()
    private let minimumTemperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureViews()
    }
    
}



// MARK: - Interface
extension ForecastListCell {
    
    func displayModel(_ model: Forecast.DailyForecasts.ViewModel.Row) {
        self.dateLabel.text = model.date
        self.weatherIconView.image = model.weatherIconName.flatMap {
            UIImage(named: $0)?.withRenderingMode(.alwaysTemplate)
        }
        self.weatherDescriptionLabel.text = model.weatherDescription
        self.maximumTemperatureLabel.text = "Max: \(model.maximumTemperature)°C"
        self.minimumTemperatureLabel.text = "Max: \(model.minimumTemperature)°C"
    }
    
}



// MARK: - Views
extension ForecastListCell {
    
    private func configureViews() {
        self.dateLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.left.right.equalTo(self.contentView.layoutMarginsGuide)
                $0.top.equalToSuperview().inset(10)
            }
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }
        self.weatherIconView.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.left.equalTo(self.contentView.layoutMarginsGuide)
                $0.width.height.equalTo(50)
                $0.top.equalTo(self.dateLabel.snp.bottom).offset(5)
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        self.minimumTemperatureLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self.weatherIconView.snp.centerY)
                $0.right.equalTo(self.contentView.layoutMarginsGuide)
            }
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.maximumTemperatureLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalTo(self.weatherIconView.snp.centerY)
                $0.right.equalTo(self.minimumTemperatureLabel.snp.left).offset(-20)
            }
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.weatherDescriptionLabel.do {
            self.contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.left.equalTo(self.weatherIconView.snp.right).offset(5)
                $0.bottom.equalTo(self.weatherIconView.snp.bottom).inset(10)
                $0.right.lessThanOrEqualTo(self.maximumTemperatureLabel.snp.left).offset(-10)
            }
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.numberOfLines = 2
        }
    }
    
}
