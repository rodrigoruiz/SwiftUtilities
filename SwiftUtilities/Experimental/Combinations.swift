//
//  Combinations.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 7/20/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import Foundation

//struct Combinations<T>: RandomAccessCollection {
//    
//    let options: [[T]]
//    let startIndex = 0
//    let endIndex: Int
//    
//    init(options: [[T]]) {
//        self.options = options.reversed()
//        self.endIndex = options.reduce(1) { $0 * $1.count }
//    }
//    
//    subscript(index: Int) -> [T] {
//        var i = index
//        var combination: [T] = []
//        combination.reserveCapacity(options.count)
//        options.forEach { option in
//            combination.append(option[i % option.count])
//            i /= option.count
//        }
//        return combination.reversed()
//    }
//    
//}
