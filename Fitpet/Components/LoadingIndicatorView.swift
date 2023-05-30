//
//  LoadingIndicatorView.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/30.
//

import UIKit
import Then
import SnapKit

final class LoadingIndicatorView: UIView {
    
    let activityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureViews()
    }
    
    deinit {
        self.activityIndicatorView.stopAnimating()
    }
    
    
    func configureViews() {
        self.activityIndicatorView.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.center.equalTo(self.safeAreaLayoutGuide)
            }
            $0.style = .large
            $0.color = .label
        }
    }
    
    override func didMoveToWindow() {
        self.activityIndicatorView.startAnimating()
    }
    
    func withDimmed(_ dimmed: Bool) {
        if dimmed {
            self.backgroundColor = .systemBackground.withAlphaComponent(0.7)
        } else {
            self.backgroundColor = nil
        }
    }
    
}
