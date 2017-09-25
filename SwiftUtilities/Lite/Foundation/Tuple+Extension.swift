//
//  Tuple+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 7/29/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public func == <T: Equatable>(lhs: [(T, T)], rhs: [(T, T)]) -> Bool {
    return lhs.elementsEqual(rhs, by: ==)
}
