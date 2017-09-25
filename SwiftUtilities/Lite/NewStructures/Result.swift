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
    
    public func flatMapFailure<F2>(_ transform: (F) -> Result<S, F2>) -> Result<S, F2> {
        switch self {
        case let .success(s):
            return .success(s)
        case let .failure(f):
            return transform(f)
        }
    }
    
    public func mapFailure<F2>(_ transform: @escaping (F) -> F2) -> Result<S, F2> {
        return flatMapFailure({ v in
            return Result<S, F2>.failure(transform(v))
        })
    }
    
    public func mapToValue<V>(_ successTransform: (S) -> V, _ failureTransform: (F) -> V) -> V {
        switch self {
        case let .success(s):
            return successTransform(s)
        case let .failure(f):
            return failureTransform(f)
        }
    }
    
}

extension Result: Monad {
    
    public static func unit(_ value: S) -> Result<S, F> {
        return Result.success(value)
    }
    
    public func flatMap<M: Monad>(_ transform: (S) -> M) -> M {
        switch self {
        case let .success(s):
            return transform(s)
        case let .failure(f):
            return Result<M.T, F>.failure(f) as! M
        }
    }
    
}

public func getSuccess<S, F>(_ result: Result<S, F>) -> S? {
    if case let .success(s) = result {
        return s
    }
    
    return nil
}

public func getFailure<S, F>(_ result: Result<S, F>) -> F? {
    if case let .failure(f) = result {
        return f
    }
    
    return nil
}

func flatMapFailure<S, F, F2>(_ transform: @escaping (F) -> Result<S, F2>) -> (Result<S, F>) -> Result<S, F2> {
    return { result in
        return result.flatMapFailure(transform)
    }
}

public func mapFailure<S, F, F2>(_ transform: @escaping (F) -> F2) -> (Result<S, F>) -> Result<S, F2> {
    return { result in
        return result.mapFailure(transform)
    }
}

public func mapToValue<S, F, V>(
    _ successTransform: @escaping (S) -> V,
    _ failureTransform: @escaping (F) -> V
) -> (Result<S, F>) -> V {
    return { result in
        return result.mapToValue(successTransform, failureTransform)
    }
}

public func mapToVoid<S, F>(_ result: Result<S, F>) -> Result<Void, F> {
    return result.map({ _ in })
}

public func mapFailureToVoid<S, F>(_ result: Result<S, F>) -> Result<S, Void> {
    return result.mapFailure({ _ in })
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
