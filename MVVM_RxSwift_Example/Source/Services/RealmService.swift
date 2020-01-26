//
//  File.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Realm
import RealmSwift

public final class RealmService {
    
    public static let shared = RealmService()
    
    public var realm: Realm {
        let config = Realm.Configuration()
        
        do {
            return try Realm(configuration: config)
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
    }
    
    fileprivate init() {}
}
