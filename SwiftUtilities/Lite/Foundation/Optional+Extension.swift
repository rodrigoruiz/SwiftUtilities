//
//  Optional+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 8/1/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func map<T1, T2>(_ transform: @escaping (T1) -> T2) -> (T1?) -> T2? {
    return { $0.map(transform) }
}

public func flatMap<T1, T2>(_ transform: @escaping (T1) -> T2?) -> (T1?) -> T2? {
    return { $0.flatMap(transform) }
}

extension Optional {
    
    public func apply<U>(_ transform: ((Wrapped) -> U)?) -> U? {
        switch transform {
        case .some(let someTransform):
            return map(someTransform)
        case .none:
            return .none
        }
    }
    
}

public func apply<T, U>(_ transform: ((T) -> U)?) -> (T?) -> U? {
    return { $0.apply(transform) }
}

func defaultTo<T>(_ defaultValue: T) -> (T?) -> T {
    return { optional in
        return optional ?? defaultValue
    }
}
