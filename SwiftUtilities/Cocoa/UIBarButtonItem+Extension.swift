//
//  UIBarButtonItem+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 7/18/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UIBarButtonItem {
    
    public convenience init(title: String) {
        self.init(title: title, style: .plain, target: nil, action: nil)
    }
    
    public convenience init(image: UIImage?) {
        self.init(image: image, style: .plain, target: nil, action: nil)
    }
    
}
