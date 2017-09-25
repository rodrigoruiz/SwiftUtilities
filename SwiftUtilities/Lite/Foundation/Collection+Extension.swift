//
//  Collection+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 9/24/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

extension Collection {
    
    public subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
