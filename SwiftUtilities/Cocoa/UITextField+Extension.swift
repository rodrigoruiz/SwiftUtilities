//
//  UITextField+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 7/26/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension UITextField {
    
    @IBInspectable public var placeholderTextColor: UIColor? {
        get {
            return attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as? UIColor
        }
        set {
            guard let color = newValue else { return }
            attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes:[NSAttributedStringKey.foregroundColor: color]
            )
        }
    }
    
    public func changeText(_ text: String) {
        guard self.text != text else { return }
        self.text = text
        sendActions(for: .valueChanged)
    }
    
}
