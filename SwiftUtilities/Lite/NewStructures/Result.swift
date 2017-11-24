//
//  Result.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

public enum Result<S, F> {
    
    case success(S)
    case failure(F)
    
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
    
    public func isSuccess() -> Bool {
        if case .success(_) = self {
            return true
        }
        
        return false
    }
    
    public func isFailure() -> Bool {
        return !isSuccess()
    }
    
    public func flatMap<S2>(_ transform: (S) -> Result<S2, F>) -> Result<S2, F> {
        switch self {
        case let .success(s):
            return transform(s)
        case let .failure(f):
            return .failure(f)
        }
    }
    
    public func map<S2>(_ transform: (S) -> S2) -> Result<S2, F> {
        return flatMap({ .success(transform($0)) })
    }
    
    public func flatMapFailure<F2>(_ transform: (F) -> Result<S, F2>) -> Result<S, F2> {
        switch self {
        case let .success(s):
            return .success(s)
        case let .failure(f):
            return transform(f)
        }
    }
    
    public func mapFailure<F2>(_ transform: @escaping (F) -> F2) -> Result<S, F2> {
        return flatMapFailure({ .failure(transform($0)) })
    }
    
    public func mapToValue<V>(_ successTransform: (S) -> V, _ failureTransform: (F) -> V) -> V {
        switch self {
        case let .success(s):
            return successTransform(s)
        case let .failure(f):
            return failureTransform(f)
        }
    }
    
    public func mapToVoid() -> Result<Void, F> {
        return map({ _ in })
    }
    
    public func mapFailureToVoid() -> Result<S, Void> {
        return mapFailure({ _ in })
    }
    
}

public func getSuccess<S, F>(_ result: Result<S, F>) -> S? {
    return result.getSuccess()
}

public func getFailure<S, F>(_ result: Result<S, F>) -> F? {
    return result.getFailure()
}

public func isSuccess<S, F>(_ result: Result<S, F>) -> Bool {
    return result.isSuccess()
}

public func isFailure<S, F>(_ result: Result<S, F>) -> Bool {
    return result.isFailure()
}

public func flatMap<S, F, S2>(_ transform: @escaping (S) -> Result<S2, F>) -> (Result<S, F>) -> Result<S2, F> {
    return { $0.flatMap(transform) }
}

public func map<S, F, S2>(_ transform: @escaping (S) -> S2) -> (Result<S, F>) -> Result<S2, F> {
    return { $0.map(transform) }
}

func flatMapFailure<S, F, F2>(_ transform: @escaping (F) -> Result<S, F2>) -> (Result<S, F>) -> Result<S, F2> {
    return { $0.flatMapFailure(transform) }
}

public func mapFailure<S, F, F2>(_ transform: @escaping (F) -> F2) -> (Result<S, F>) -> Result<S, F2> {
    return { $0.mapFailure(transform) }
}

public func mapToValue<S, F, V>(
    _ successTransform: @escaping (S) -> V,
    _ failureTransform: @escaping (F) -> V
) -> (Result<S, F>) -> V {
    return { $0.mapToValue(successTransform, failureTransform) }
}

public func mapToVoid<S, F>(_ result: Result<S, F>) -> Result<Void, F> {
    return result.mapToVoid()
}

public func mapFailureToVoid<S, F>(_ result: Result<S, F>) -> Result<S, Void> {
    return result.mapFailureToVoid()
}

public func reduceResults<S, F, S2>(_ initialResultValue: S2, _ nextPartialResultValue: @escaping (S2, S) -> S2) -> ([Result<S, F>]) -> Result<S2, F> {
    return { results in
        return results.reduce(Result<S2, F>.success(initialResultValue), { result, next in
            switch (result, next) {
            case let (.success(r), .success(n)):
                return .success(nextPartialResultValue(r, n))
            case let (.failure(error), _):
                return .failure(error)
            case let (_, .failure(error)):
                return .failure(error)
            default:
                fatalError()
            }
        })
    }
}

public func == <S: Equatable, F: Equatable>(lhs: Result<S, F>, rhs: Result<S, F>) -> Bool {
    switch (lhs, rhs) {
    case let (.success(left), .success(right)):
        return left == right
    case let (.failure(left), .failure(right)):
        return left == right
    default:
        return false
    }
}
