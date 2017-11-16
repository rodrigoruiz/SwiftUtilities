//
//  UIColor+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 11/16/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UIColor {
    
    public convenience init(hex: String) {
        var uppercasedString = hex.uppercased()
        uppercasedString.removeFirst()
        
        var rgbValue: UInt32 = 0
        Scanner(string: uppercasedString).scanHexInt32(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
}
