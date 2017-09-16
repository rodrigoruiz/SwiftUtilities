//
//  Applicative.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 8/7/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import Foundation


public protocol Applicative {
    
    associatedtype T
    
    func apply<AF: Applicative, AV: Applicative, U>(_ transform: AF) -> AV where AF.T == ((T) -> U), AV.T == U
    
}
