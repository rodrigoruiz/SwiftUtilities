//
//  Observable+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 4/25/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import RxSwift


extension Observable {
    
    // call resume() to allow the next event to be sent
    public func subscribeNextAndWait(_ onNext: @escaping (Observable.E, _ resume: @escaping (() -> Void)) -> Void) -> Disposable {
        return observeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "NewThread"))
            .subscribe(onNext: { next in
                let condition = NSCondition()
                
                DispatchQueue.main.async(execute: {
                    onNext(next, {
                        condition.signal()
                    })
                })
                
                condition.lock()
                condition.wait()
                condition.unlock()
            })
    }
    
}

public func map<T1, T2>(_ transform: @escaping (T1) -> T2) -> (Observable<T1>) -> Observable<T2> {
    return { $0.map(transform) }
}

public func flatMap<T1, T2>(_ transform: @escaping (T1) -> Observable<T2>) -> (Observable<T1>) -> Observable<T2> {
    return { $0.flatMap(transform) }
}

extension Array where Element: ObservableConvertibleType {
    
    public func toArrayObservable() -> Observable<[Element.E]> {
        return Observable.from(self).concat().toArray()
    }
    
}

public func toArrayObservable<Element: ObservableConvertibleType>(_ array: [Element]) -> Observable<[Element.E]> {
    return Observable.from(array).concat().toArray()
}

extension Array {
    
    public func mapToArrayObservable<T: ObservableConvertibleType>(_ transform: (Element) throws -> T) rethrows -> Observable<[T.E]> {
        return try self.map(transform).toArrayObservable()
    }
    
}
