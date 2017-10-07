//
//  ReSwift+Extension.swift
//  SwiftUtilities
//
//  Created by Rodrigo Ruiz on 10/1/17.
//  Copyright © 2017 Rodrigo Ruiz. All rights reserved.
//

import ReSwift
import RxSwift

extension Store {
    
    func dispatchObservable(_ callbackActionCreator: @escaping (@escaping () -> Void) -> (State, Store<State>) -> Action?) -> Observable<State> {
        return Observable.create({ observer in
            let actionCreator = callbackActionCreator({
                observer.onNext(self.state)
                observer.onCompleted()
            })
            
            self.dispatch(actionCreator)
            
            return Disposables.create()
        })
    }
    
}
