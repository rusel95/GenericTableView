//
//  ObservableType+HandyFunctions.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    public func doOnNext(_ onNext: ((Self.Element) -> Swift.Void)?) -> Disposable {
        return subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
}
