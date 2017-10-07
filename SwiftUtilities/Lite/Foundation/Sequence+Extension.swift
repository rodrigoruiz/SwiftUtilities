//
//  Sequence+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Sequence {
    
    public func reduce(_ combine: (Self.Iterator.Element, Self.Iterator.Element) -> Self.Iterator.Element) -> Self.Iterator.Element {
        let initial: Self.Iterator.Element? = nil
        return reduce(initial, { (result, element) in
            guard let result = result else { return element }
            
            return combine(result, element)
        })!
    }
    
    public func take(_ numberOfElements: Int) -> Self.SubSequence {
        return prefix(numberOfElements)
    }
    
}

public func take<S: Sequence>(_ numberOfElements: Int) -> (S) -> S.SubSequence {
    return { $0.take(numberOfElements) }
}

public func map<S: Sequence, E>(_ transform: @escaping (S.Element) -> E) -> (S) -> [E] {
    return { $0.map(transform) }
}

public func filter<S: Sequence>(_ isIncluded: @escaping (S.Element) -> Bool) -> (S) -> [S.Element] {
    return { $0.filter(isIncluded) }
}

