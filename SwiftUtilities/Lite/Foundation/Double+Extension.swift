//
//  Double+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 7/21/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func isWithinError(expectedValue: Double, actualValue: Double, errorMargin: Double) -> Bool {
    if actualValue > expectedValue + errorMargin {
        return false
    }
    
    if actualValue < expectedValue - errorMargin {
        return false
    }
    
    return true
}
