//
//  AsyncRequestState.swift
//  SwiftUtilities
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
    
    func map<S2>(_ transform: (S) -> S2) -> AsyncRequestState<S2, F> {
        switch self {
        case .none:
            return .none
        case .waiting:
            return .waiting
        case let .success(s):
            return .success(transform(s))
        case let .failure(f):
            return .failure(f)
        }
    }
    
}

public func == <S: Equatable, F: Equatable>(lhs: AsyncRequestState<S, F>, rhs: AsyncRequestState<S, F>) -> Bool {
    switch (lhs, rhs) {
    case (.none, .none), (.waiting, .waiting):
        return true
    case let (.success(left), .success(right)):
        return left == right
    case let (.failure(left), .failure(right)):
        return left == right
    default:
        return false
    }
}
