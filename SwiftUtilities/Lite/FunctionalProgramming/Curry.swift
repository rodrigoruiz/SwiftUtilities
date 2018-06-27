//
//  Curry.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 6/26/18.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in
        return { b in
            return f(a, b)
        }
    }
}
