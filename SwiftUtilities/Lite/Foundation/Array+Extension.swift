//
//  Array+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Array {
    
    public func find<T>(_ includeElement: (Element, Int) -> T?) -> T? {
        for (index, element) in enumerated() {
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
        for (index, element) in enumerated() {
            if includeElement(element) {
                return index
            }
        }
        
        return nil
    }
    
    public func map<T>(_ transform: (Element, Int) -> T) -> [T] {
        return enumerated().map({ transform($1, $0) })
    }
    
    public func take(_ numberOfElements: Int) -> [Element] {
        return Array(prefix(numberOfElements))
    }
    
}

public func take<T>(_ numberOfElements: Int) -> ([T]) -> [T] {
    return { $0.take(numberOfElements) }
}

extension Array where Element: OptionalType {
    
    public func filterOutNils() -> [Element.Wrapped] {
        return flatMap({ $0.optional })
    }
    
}

public func filterOutNils<T>(_ array: [T?]) -> [T] {
    return array.filterOutNils()
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
