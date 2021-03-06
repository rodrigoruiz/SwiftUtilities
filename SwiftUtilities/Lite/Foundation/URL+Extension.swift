//
//  URL+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension URL {
    
    public var resourceSpecifier: String? {
        get {
            guard let scheme = scheme else { return nil }
            
            // scheme://resourceSpecifier
            return absoluteString.substring(from: scheme.count + 3)
        }
    }
    
}
