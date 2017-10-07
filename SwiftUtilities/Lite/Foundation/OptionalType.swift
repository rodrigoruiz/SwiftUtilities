//
//  OptionalType.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 9/30/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public protocol OptionalType {
    
    associatedtype Wrapped
    var optional: Wrapped? { get }
    
}

extension Optional: OptionalType {
    
    public var optional: Wrapped? { return self }
    
}
