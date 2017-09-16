//
//  Sequence+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Sequence {
    
    public func reduce(_ combine: (Self.Iterator.Element, Self.Iterator.Element) -> Self.Iterator.Element) -> Self.Iterator.Element {
        let initial: Self.Iterator.Element?  = nil
        return self.reduce(initial, { (result, element) in
            guard let result = result else { return element }
            
            return combine(result, element)
        })!
    }
    
}


extension Collection where Indices.Iterator.Element == Index {
    
    public subscript(_ index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

public func map<T1, T2>(_ transform: @escaping (T1) -> T2) -> (AnySequence<T1>) -> [T2] {
    return { s1 in
        return s1.map(transform)
    }
}
