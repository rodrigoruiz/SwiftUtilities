//
//  FunctionPipe.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 7/17/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

precedencegroup PipeFunctionsPrecedence {
    
    associativity: left
    higherThan: BitwiseShiftPrecedence
    
}
infix operator >>> : PipeFunctionsPrecedence

public func >>> <T1, T2, T3>(left: @escaping (T1) -> T2, right: @escaping (T2) -> T3) -> (T1) -> T3 {
    return { right(left($0)) }
}

public func >>> <T1, T2>(left: T1, right: (T1) -> T2) -> T2 {
    return right(left)
}

public func >>> <T1, T2, T3>(left: ((T1) -> T2)?, right: ((T2) -> T3)?) -> ((T1) -> T3)? {
    switch (left, right) {
    case let (.some(someLeft), .some(someRight)):
        return someLeft >>> someRight
    default:
        return .none
    }
}
