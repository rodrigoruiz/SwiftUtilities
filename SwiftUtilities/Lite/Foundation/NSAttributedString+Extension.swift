//
//  NSAttributedString+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 5/3/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension NSAttributedString {
    
    public static func attributedString(with text: String, font: UIFont? = nil, color: UIColor? = nil) -> NSAttributedString {
        var attributes = [NSAttributedStringKey: Any]()
        
        if let font = font {
            attributes[NSAttributedStringKey.font] = font
        }
        
        if let color = color {
            attributes[NSAttributedStringKey.foregroundColor] = color
        }
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    public func changeString(_ newString: String) -> NSAttributedString {
        let mutableString = self.mutableCopy() as! NSMutableAttributedString
        mutableString.mutableString.setString(newString)
        return mutableString
    }
    
    public func replaceCharacters(inRange: NSRange, withString: String) -> NSAttributedString {
        let mutableString = mutableCopy() as! NSMutableAttributedString
        mutableString.replaceCharacters(in: inRange, with: withString)
        return mutableString
    }
    
    public func replaceCharacters(inRange: NSRange, withAttributedString: NSAttributedString) -> NSAttributedString {
        let mutableString = mutableCopy() as! NSMutableAttributedString
        mutableString.replaceCharacters(in: inRange, with: withAttributedString)
        return mutableString
    }
    
}

public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}

public func + (left: String, right: NSAttributedString) -> NSAttributedString {
    return NSAttributedString(string: left) + right
}

public func + (left: NSAttributedString, right: String) -> NSAttributedString {
    return left + NSAttributedString(string: right)
}
