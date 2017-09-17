//
//  Monad.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 7/20/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public protocol Monad {
    
    associatedtype T
    
    static func unit(_ value: T) -> Self
    
    func flatMap<M: Monad>(_ transform: (T) -> M) -> M
    
}

extension Monad {
    
    public func map<M: Monad, U>(_ transform: (T) -> U) -> M where M.T == U {
        return flatMap({ v in
            return M.unit(transform(v))
        })
    }
    
}

public func flatMap<M1: Monad, M2: Monad>(_ transform: @escaping (M1.T) -> M2) -> (M1) -> M2 {
    return { m1 in
        return m1.flatMap(transform)
    }
}

public func map<M1: Monad, M2: Monad>(_ transform: @escaping (M1.T) -> M2.T) -> (M1) -> M2 {
    return { m1 in
        return m1.map(transform)
    }
}
