//
//  UINavigationController+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UINavigationController {
    
    //    func pushViewController(viewController: UIViewController, animated: Bool, completion: () -> ()) {
    //        CATransaction.begin()
    //        CATransaction.setCompletionBlock(completion)
    //        self.pushViewController(viewController, animated: animated)
    //        CATransaction.commit()
    //    }
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        pushViewController(viewController, animated: animated)
        
        if let coordinator = transitionCoordinator , animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    public func popViewControllerAnimated(_ animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    public func popToRootViewControllerAnimated(_ animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    
}
