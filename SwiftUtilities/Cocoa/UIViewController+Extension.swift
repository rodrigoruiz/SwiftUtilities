//
//  UIViewController+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UIViewController {
    
    public static func fromStoryboard(name: String = "Main") -> Self {
        func fromStoryboardHelper<T>(_ identifier: String) -> T where T : UIViewController {
            return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
        }
        
        return fromStoryboardHelper(String(describing: self))
    }
    
    public func addChildViewController(_ childController: UIViewController, toView: UIView) {
        addChildViewController(childController)
        toView.addSubview(childController.view)
        childController.didMove(toParentViewController: self)
    }
    
    public func removeFromParentVC() {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
}
