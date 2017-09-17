//
//  Functions.swift
//  MyLibrary
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
