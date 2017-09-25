//
//  JSON+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 9/12/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import SwiftyJSON

extension JSON {
    
    public func isNull() -> Bool {
        return null != nil
    }
    
    public init<T>(optional: T?) {
        if let value = optional {
            self = JSON(value)
        }
        
        self = JSON.null
    }
    
}
