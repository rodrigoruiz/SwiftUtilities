//
//  Comparable+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 7/17/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func isBetween<T: Comparable>(min: T, value: T, max: T) -> Bool {
    if value < min {
        return false
    }
    
    if value > max {
        return false
    }
    
    return true
}

public func restrict<T: Comparable>(min: T, value: T, max: T) -> T {
    if value < min {
        return min
    }
    
    if value > max {
        return max
    }
    
    return value
}
