//
//  RxBinding.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

//swiftlint:disable line_length
import RxSwift
import RxCocoa

infix operator <->

/// two-way binding
public func <-> <T, U>(observer: U, variable: BehaviorRelay<T>) -> Disposable where U: ObservableType, U: ObserverType, U.Element == T, T: Equatable {
    let leftDisposable = observer.asObservable().distinctUntilChanged().bind(to: variable)
    let rightDisposable = variable.asObservable().bind(to: observer)
    
    return Disposables.create(rightDisposable, leftDisposable)
}

/// two-way binding
public func <-> <T>(observer: BehaviorRelay<T>, variable: BehaviorRelay<T>) -> Disposable where T: Equatable {
    let leftDisposable = observer.asObservable().distinctUntilChanged().bind(to: variable)
    let rightDisposable = variable.asObservable().bind(to: observer)
    
    return Disposables.create(rightDisposable, leftDisposable)
}

public func <-> <T>(observer: BehaviorRelay<[T]>, variable: BehaviorRelay<[T]>) -> Disposable where T: Equatable {
    let leftDisposable = observer.asObservable().distinctUntilChanged { $0.elementsEqual($1) } .bind(to: variable)
    let rightDisposable = variable.asObservable().bind(to: observer)
    
    return Disposables.create(rightDisposable, leftDisposable)
}

/// two-way binding with optional unwrapping
public func <-> <T>(observer: BehaviorRelay<T?>, variable: BehaviorRelay<T?>) -> Disposable where T: Equatable {
    let leftDisposable = observer.asObservable().unwrap().distinctUntilChanged().bind(to: variable)
    let rightDisposable = variable.asObservable().bind(to: observer)
    
    return Disposables.create(rightDisposable, leftDisposable)
}

/// two-way binding with optional unwrapping
public func <-> <T, U>(observer: U, variable: BehaviorRelay<T>) -> Disposable where U: ObservableType, U: ObserverType, U.Element == T?, T: Equatable {
    let leftDisposable = observer.unwrap().distinctUntilChanged().bind(to: variable)
    let rightDisposable = variable.asObservable().bind(to: observer)
    
    return Disposables.create(rightDisposable, leftDisposable)
}

infix operator >

/// binds given observable to observer
public func > <T, U>(observable: U, observer: T) -> Disposable where U: ObservableType, T: ObserverType, U.Element == T.Element {
    return observable.subscribe { event in
        switch event {
        case .completed:
            observer.onCompleted()
            
        case .error(let error):
            observer.onError(error)
            
        case .next(let element):
            observer.onNext(element)
        }
    }
}

/// binds given observable to observer
public func > <T, U>(observable: U, observer: BehaviorRelay<T>) -> Disposable where U: ObservableType, U.Element == T {
    return observable.subscribe { event in
        switch event {
        case .next(let element):
            observer.accept(element)
            
        default:
            break
        }
    }
}
