//
//  Sequence+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Sequence {
    
    public func map<T>(_ transform: (Element, Int) -> T) -> [T] {
        return enumerated().map({ transform($1, $0) })
    }
    
    public func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map({ $0[keyPath: keyPath] })
    }
    
    public func flatMap<T>(_ keyPath: KeyPath<Element, [T]>) -> [T] {
        return flatMap({ $0[keyPath: keyPath] })
    }
    
    public func reduce(_ combine: (Self.Iterator.Element, Self.Iterator.Element) -> Self.Iterator.Element) -> Self.Iterator.Element {
        let initial: Self.Iterator.Element? = nil
        return reduce(initial, { (result, element) in
            guard let result = result else { return element }
            
            return combine(result, element)
        })!
    }
    
    public func foldl<R>(_ initialResult: R, _ nextPartialResult: (R, Self.Element) -> R) -> R {
        return reduce(initialResult, nextPartialResult)
    }
    
    public func foldr<R>(_ initialResult: R, _ nextPartialResult: (R, Self.Element) -> R) -> R {
        return reversed().lazy.reduce(initialResult, nextPartialResult)
    }
    
    public func take(_ numberOfElements: Int) -> Self.SubSequence {
        return prefix(numberOfElements)
    }
    
}

public func map<S: Sequence, E>(_ transform: @escaping (S.Element) -> E) -> (S) -> [E] {
    return { $0.map(transform) }
}

public func map<S: Sequence, E>(_ transform: @escaping (S.Element, Int) -> E) -> (S) -> [E] {
    return { $0.map(transform) }
}

public func map<S: Sequence, E>(_ keyPath: KeyPath<S.Element, E>) -> (S) -> [E] {
    return { $0.map(keyPath) }
}

public func filter<S: Sequence>(_ isIncluded: @escaping (S.Element) -> Bool) -> (S) -> [S.Element] {
    return { $0.filter(isIncluded) }
}

public func reduce<S: Sequence, R>(_ nextPartialResult: @escaping (R, S.Element) -> R) -> (R) -> (S) -> R {
    return { initialResult in
        return { sequence in
            return sequence.reduce(initialResult, nextPartialResult)
        }
    }
}

public func reduce<S: Sequence>(_ nextPartialResult: @escaping (S.Element, S.Element) -> S.Element) -> (S) -> S.Element {
    return { $0.reduce(nextPartialResult) }
}

public func foldl<S: Sequence, R>(_ nextPartialResult: @escaping (R, S.Element) -> R) -> (R) -> (S) -> R {
    return { initialResult in
        return { sequence in
            return sequence.foldl(initialResult, nextPartialResult)
        }
    }
}

public func foldr<S: Sequence, R>(_ nextPartialResult: @escaping (R, S.Element) -> R) -> (R) -> (S) -> R {
    return { initialResult in
        return { sequence in
            return sequence.foldr(initialResult, nextPartialResult)
        }
    }
}

public func take<S: Sequence>(_ numberOfElements: Int) -> (S) -> S.SubSequence {
    return { $0.take(numberOfElements) }
}

extension Sequence where Element: Sequence {
    
    public func flatten() -> FlattenSequence<Self> {
        return joined()
    }
    
}

public func flatten<S: Sequence>(_ sequence: S) -> FlattenSequence<S> where S.Element: Sequence {
    return sequence.flatten()
}

extension Sequence where Element: OptionalType {
    
    public func filterOutNils() -> [Element.Wrapped] {
        return compactMap({ $0.optional })
    }
    
}

public func filterOutNils<S: Sequence>(_ array: S) -> [S.Element.Wrapped] where S.Element: OptionalType {
    return array.filterOutNils()
}
