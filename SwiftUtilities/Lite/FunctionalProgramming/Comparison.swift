//
//  Comparison.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 6/27/18.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

func greaterThan<C: Comparable>(_ right: C) -> (C) -> Bool {
    return { left in
        return left > right
    }
}

func lessThan<C: Comparable>(_ right: C) -> (C) -> Bool {
    return { left in
        return left < right
    }
}

func equals<E: Equatable>(_ right: E) -> (E) -> Bool {
    return { left in
        return left == right
    }
}
