//
//  Functions.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 5/17/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func mapToNil<V, T>(_ parameterToIgnore: V) -> T? {
    return nil
}

public func asType<T, V>(_ type: T.Type) -> (V) -> T? {
    return { value in
        return value as? T
    }
}

public func const<C, I>(_ c: C) -> (I) -> C {
    return { _ in c }
}

public func ifElse<I, O>(
    _ condition: @escaping (I) -> Bool,
    _ ifTransform: @escaping (I) -> O,
    _ elseTransform: @escaping (I) -> O
) -> (I) -> (O) {
    return { input in
        if condition(input) {
            return ifTransform(input)
        } else {
            return elseTransform(input)
        }
    }
}

public func getKeyPath<E, V>(_ keyPath: KeyPath<E, V>) -> (E) -> V {
    return { element in
        return element[keyPath: keyPath]
    }
}
