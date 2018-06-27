//
//  Arrow.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 6/26/18.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

func split<I, O1, O2>(_ first: @escaping (I) -> O1, _ second: @escaping (I) -> O2) -> (I) -> (O1, O2) {
    return { input in
        return (first(input), second(input))
    }
}

func unsplit<I1, I2, O>(_ f: @escaping (I1, I2) -> O) -> ((I1, I2)) -> O {
    return { tuple in
        return f(tuple.0, tuple.1)
    }
}

func split<T>(_ t: T) -> (T, T) {
    return (t, t)
}

func first<T1, T2, O>(_ f: @escaping (T1) -> O) -> ((T1, T2)) -> (O, T2) {
    return { tuple in
        return (f(tuple.0), tuple.1)
    }
}

func second<T1, T2, O>(_ f: @escaping (T2) -> O) -> ((T1, T2)) -> (T1, O) {
    return { tuple in
        return (tuple.0, f(tuple.1))
    }
}

func both<I, O>(_ f: @escaping (I) -> O) -> ((I, I)) -> (O, O) {
    return { tuple in
        return (f(tuple.0), f(tuple.1))
    }
}
