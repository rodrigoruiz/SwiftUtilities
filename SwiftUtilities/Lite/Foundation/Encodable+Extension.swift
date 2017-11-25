//
//  Encodable+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 11/24/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Encodable {
    
    public func asDictionary() -> [String: Any] {
        let data = try! JSONEncoder().encode(self)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return dictionary as! [String: Any]
    }
    
}
