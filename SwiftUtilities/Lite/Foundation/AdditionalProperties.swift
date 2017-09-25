//
//  AdditionalProperties.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public protocol AdditionalProperties: AnyObject {
    
    var properties: [String: AnyObject] { get set }
    
}

extension AdditionalProperties {
    
    var properties: [String: AnyObject] {
        get {
            if objc_getAssociatedObject(self, &propertiesKey) == nil {
                properties = [:]
            }
            
            return objc_getAssociatedObject(self, &propertiesKey) as! [String: AnyObject]
        }
        set {
            objc_setAssociatedObject(self, &propertiesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

// MARK: - Private

private var propertiesKey = 0
