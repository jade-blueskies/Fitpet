//
//  ToastView.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/30.
//

import UIKit
import Then
import SnapKit

final class ToastView: UIView {
    
    private let messageLabel = UILabel()
    private let message: String
    
    
    required init(message: String) {
        self.message = message
        super.init(frame: .zero)
        self.configureViews()
    }
    required init?(coder: NSCoder) {
        return nil
    }
    
    
    private func configureViews() {
        self.do {
            $0.backgroundColor = .label
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        self.messageLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(20)
            }
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .systemBackground
            $0.text = self.message
        }
    }
    
}
