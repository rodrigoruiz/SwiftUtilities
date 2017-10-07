//
//  Dictionary+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func + <K, V>(left: [K: V], right: [K: V]) -> [K: V] {
    var dict = [K: V]()
    for (k, v) in left {
        dict[k] = v
    }
    for (k, v) in right {
        dict[k] = v
    }
    return dict
}

extension Dictionary {
    
    public func mapToDictionary<K, V>(_ transform: ((key: Key, value: Value)) -> (K, V)) -> [K: V] {
        var result = [K: V]()
        
        for (key, value) in self {
            let (newKey, newValue) = transform((key, value))
            result[newKey] = newValue
        }
        
        return result
    }
    
}

extension Dictionary where Value: OptionalType {
    
    public func filterOutNils() -> [Key: Value.Wrapped] {
        return filter({ $0.value.optional != nil }).mapValues({ $0.optional! })
    }
    
}

public func filterOutNils<K, V>(_ dictionary: [K: V?]) -> [K: V] {
    return dictionary.filterOutNils()
}
