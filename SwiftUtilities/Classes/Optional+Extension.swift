//
//  Optional+Extension.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 8/1/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func map<T1, T2>(_ transform: @escaping (T1) -> T2) -> (T1?) -> T2? {
    return { s1 in
        return s1.map(transform)
    }
}

extension Optional {
    
    public func apply<U>(_ f: ((Wrapped) -> U)?) -> U? {
        switch f {
        case .some(let someF):
            return map(someF)
        case .none:
            return .none
        }
    }
    
}
