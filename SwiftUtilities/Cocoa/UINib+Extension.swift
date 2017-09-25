//
//  UINib+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 6/29/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UINib {
    
    public static func instantiateView<T: UIView>() -> T {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        guard let view = nib.instantiate(withOwner: nil, options: nil)[0] as? T else {
            fatalError()
        }
        return view
    }
    
}
