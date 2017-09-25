//
//  UIStoryboard+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/28/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UIStoryboard {
    
    public func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError()
        }
        
        return viewController
    }
    
}
