//
//  Functions.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func flip<I1, I2, O>(_ function: @escaping (I1, I2) -> O) -> (I2, I1) -> O {
    return { function($1, $0) }
}
