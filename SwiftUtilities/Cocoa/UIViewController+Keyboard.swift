//
//  UIViewController+Keyboard.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 8/24/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import RxCocoa
import RxSwift


extension UIViewController {
    
    public func setupKeyboardNotifications(show: @escaping (_ keyboardFrame: CGRect) -> Void, hide: @escaping () -> Void) -> Disposable {
        var isKeyboardShowing = false
        
        let showDisposable = NotificationCenter.default.rx.notification(.UIKeyboardWillShow).subscribe(onNext: { [weak self] notification in
            if isKeyboardShowing { return }
            isKeyboardShowing = true
            
            let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect ?? CGRect()
            show(keyboardFrame)
            
            let duration = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? Double ?? 0
            UIView.animate(withDuration: duration, animations: {
                self?.view.layoutIfNeeded()
            })
        })
        
        let hideDisposable = NotificationCenter.default.rx.notification(.UIKeyboardWillHide).subscribe(onNext: { [weak self] notification in
            if !isKeyboardShowing { return }
            isKeyboardShowing = false
            
            hide()
            
            let duration = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? Double ?? 0
            UIView.animate(withDuration: duration, animations: {
                self?.view.layoutIfNeeded()
            })
        })
        
        return CompositeDisposable(showDisposable, hideDisposable)
    }
    
}
