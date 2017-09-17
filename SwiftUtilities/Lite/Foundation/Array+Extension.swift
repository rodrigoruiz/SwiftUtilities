//
//  Array+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Array {
    
    public func find<T>(_ includeElement: (Element, Int) -> T?) -> T? {
        for (index, element) in self.enumerated() {
            if let t = includeElement(element, index) {
                return t
            }
        }
        
        return nil
    }
    
    public func find(_ includeElement: (Array.Iterator.Element) -> Bool) -> Array.Iterator.Element? {
        for element in self {
            if includeElement(element) {
                return element
            }
        }
        
        return nil
    }
    
    public func findIndex(_ includeElement: (Array.Iterator.Element) -> Bool) -> Int? {
        for (index, element) in self.enumerated() {
            if includeElement(element) {
                return index
            }
        }
        
        return nil
    }
    
    public func take(_ numberOfElements: Int) -> [Element] {
        return Array(prefix(numberOfElements))
    }
    
}

public func == <T: Equatable>(lhs: [[T]]?, rhs: [[T]]?) -> Bool {
    switch (lhs, rhs) {
    case let (.some(lhs), .some(rhs)):
        return lhs.elementsEqual(rhs, by: { $0 == $1 })
    case (.none, .none):
        return true
    default:
        return false
    }
}
