//
//  ToastDisplayable.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/30.
//

import UIKit
import Then
import SnapKit


protocol ToastDisplayable: FIPTExtendable where Self: AnyObject {
    var toastBaseView: UIView { get }
}

extension ToastDisplayable where Self: UIViewController {
    var toastBaseView: UIView { self.view }
}

extension ToastDisplayable where Self: UIView {
    var toastBaseView: UIView { self }
}



// MARK: - Interface
extension FIPTExtension where Extension == FIPTExtendable, Base: ToastDisplayable {
    
    func showToast(withMessage message: String) {
        let toast = self.base.addToast(message: message)
        self.base.animateAppearace(toast)
        DispatchQueue.main.asyncAfter(deadline: .now() + self.base.displayingDuration) { [weak base] in
            base?.animateDisappearace(toast) {
                base?.removeToast(toast)
            }
        }
    }
    
}



// MARK: - Implementation
extension ToastDisplayable {
    
    fileprivate var displayingDuration: DispatchTimeInterval { .milliseconds(2000) }
    
    fileprivate func addToast(message: String) -> UIView {
        return ToastView(message: message).then {
            self.toastBaseView.addSubview($0)
            $0.snp.makeConstraints {
                $0.left.right.equalTo(self.toastBaseView.safeAreaLayoutGuide).inset(40)
                $0.bottom.equalTo(self.toastBaseView.safeAreaLayoutGuide).inset(20)
            }
        }
    }
    
    fileprivate func removeToast(_ toast: UIView) {
        toast.removeFromSuperview()
    }
    
    
    fileprivate func animateAppearace(_ toast: UIView) {
        toast.alpha = 0
        UIView.animate(withDuration: 0.2) {
            toast.alpha = 1
        }
    }
    
    fileprivate func animateDisappearace(_ toast: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            toast.alpha = 0
        }, completion: { _ in
            completion()
        })
    }
    
}
