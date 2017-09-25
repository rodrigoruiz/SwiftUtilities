//
//  Functor.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 8/7/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public protocol Functor {
    
    associatedtype T
    
    func map<F: Functor, U>(_ transform: (T) -> U) -> F where F.T == U
    
}
