//
//  AsyncRequestState.swift
//  MyLibrary
//
//  Created by Rodrigo Ruiz on 8/21/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public enum AsyncRequestState<S, F> {
    
    case none
    case waiting
    case success(S)
    case failure(F)
    
    public init(result: Result<S, F>) {
        switch result {
        case let .success(s):
            self = .success(s)
        case let .failure(f):
            self = .failure(f)
        }
    }
    
    public func getSuccess() -> S? {
        if case let .success(s) = self {
            return s
        }
        
        return nil
    }
    
    public func getFailure() -> F? {
        if case let .failure(f) = self {
            return f
        }
        
        return nil
    }
    
    public func toResult() -> Result<S, F>? {
        switch self {
        case .none, .waiting:
            return nil
        case let .success(s):
            return .success(s)
        case let .failure(f):
            return .failure(f)
        }
    }
    
}
