//
//  LoadingIndicatorDisplayable.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/30.
//

import UIKit
import Then
import SnapKit

protocol LoadingIndicatorDisplayable: FIPTExtendable where Self: AnyObject {
    var loadingIndicatorBaseView: UIView { get }
}

extension LoadingIndicatorDisplayable where Self: UIViewController {
    var loadingIndicatorBaseView: UIView { self.view }
}

extension LoadingIndicatorDisplayable where Self: UIView {
    var loadingIndicatorBaseView: UIView { self }
}



// MARK: - Interface
extension FIPTExtension where Extension == FIPTExtendable, Base: LoadingIndicatorDisplayable {
    
    func showLoadingIndicator(withDimmed dimmed: Bool) {
        guard !self.base.isIndicatorShowing else { return }
        self.base.isIndicatorShowing = true
        self.base.addIndicator(withDimmed: dimmed)
        self.base.animateAppearance()
    }
    
    func hideLoadingIndicator() {
        guard self.base.isIndicatorShowing else { return }
        self.base.isIndicatorShowing = false
        self.base.animateDisappearance { [weak base] in
            guard base?.isIndicatorShowing == false else { return }
            base?.removeIndicator()
        }
    }
    
}



// MARK: - Implementation
private var viewPointer: UInt = 0
private var boolPointer: UInt = 0
extension LoadingIndicatorDisplayable {
    
    fileprivate var indicatorView: LoadingIndicatorView? {
        get { objc_getAssociatedObject(self, &viewPointer) as? LoadingIndicatorView }
        set { objc_setAssociatedObject(self, &viewPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    fileprivate var isIndicatorShowing: Bool {
        get { (objc_getAssociatedObject(self, &boolPointer) as? Bool) ?? false }
        set { objc_setAssociatedObject(self, &boolPointer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    fileprivate func addIndicator(withDimmed dimmed: Bool) {
        self.indicatorView = LoadingIndicatorView().then {
            self.loadingIndicatorBaseView.addSubview($0)
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            $0.withDimmed(dimmed)
        }
    }
    
    fileprivate func removeIndicator() {
        self.indicatorView?.removeFromSuperview()
        self.indicatorView = nil
    }
    
    
    fileprivate func animateAppearance() {
        if self.indicatorView?.alpha == 1 {
            self.indicatorView?.alpha = 0
        }
        UIView.animate(withDuration: 0.2) {
            self.indicatorView?.alpha = 1
        }
    }
    
    fileprivate func animateDisappearance(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            self.indicatorView?.alpha = 0
        }, completion: { _ in
            completion()
        })
    }
    
}
