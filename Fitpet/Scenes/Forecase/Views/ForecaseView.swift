//
//  ForecaseView.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/26.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class ForecaseView: UIView {
    
    private let listView = UITableView()
    
    
    
    
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
extension ForecaseView {
    
}



// MARK: - Logic
extension ForecaseView {
    
    private func bindWithInteractions() {
        
    }
    
}



// MARK: - Views
extension ForecaseView {
    
    private func configureViews() {
        self.backgroundColor = .systemBackground
    }
    
}
