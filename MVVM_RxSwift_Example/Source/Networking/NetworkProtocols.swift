//
//  NetworkProtocols.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import CoreData

protocol BaseSerializer {
    
    func mapResponse<T: NSManagedObject>(
        _
        response: [String: AnyObject],
        contentKey: String
        ) -> Observable<[T]>
    
}

protocol ResponseHandler {
    
    associatedtype Value
    
    var baseContentKey: String { get }
    
    func handleResponse(_ response: Data) -> Observable<Value>
    
}

extension ResponseHandler {
    
    var baseContentKey: String { return "data" }
    
    func unwrapToDictionary(_ data: Any, with contentKey: String) -> Observable<[String: Any]> {
        guard let data = data as? [String: AnyObject],
            let result = data[contentKey] as? [String: Any] else {
                return Observable.error(ExampleError.serializationFault)
        }
        
        return Observable.just(result)
    }
    
    func unwrapToDictionaryOrNil(_ data: Any, with contentKey: String) -> Observable<[String: Any]?> {
        guard let data = data as? [String: AnyObject],
            let result = data[contentKey] as? [String: Any] else {
                return Observable.just(nil)
        }
        
        return Observable.just(result)
    }
    
    func unwrapToArray(_ data: Any, with contentKey: String) -> Observable<[[String: Any]]> {
        guard let data = data as? [String: AnyObject],
            let result = data[contentKey] as? [[String: Any]] else {
                return Observable.error(ExampleError.serializationFault)
        }
        
        return Observable.just(result)
    }
    
    func unwrapToSimpleArray(_ data: Any, with contentKey: String) -> Observable<[Any]> {
        guard let data = data as? [String: AnyObject],
            let result = data[contentKey] as? [Any] else {
                return Observable.error(ExampleError.serializationFault)
        }
        
        return Observable.just(result)
    }
    
}
