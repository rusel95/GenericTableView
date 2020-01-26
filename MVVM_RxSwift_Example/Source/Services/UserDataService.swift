//
//  UserDataService.swift
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public enum UserDataServiceKey: String {
    
    case isFirstStart
    case savedTime
    
}

public class UserDataService {
    
    public static func observe<E: KVORepresentable>(
        _ type: E.Type,
        _ key: UserDataServiceKey,
        options: KeyValueObservingOptions = [.new, .initial],
        retainSelf: Bool = true) -> Observable<E?> {
        
        return UserDefaults.standard.rx.observe(type, key.rawValue, options: options, retainSelf: retainSelf)
    }
    
    public static func set(_ value: Any?, for key: UserDataServiceKey) {
        return UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public static func array(for key: UserDataServiceKey) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.rawValue)
    }
    
    public static func object(for key: UserDataServiceKey) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    public static func string(for key: UserDataServiceKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    public static func bool(for key: UserDataServiceKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    public static func removeObject(for key: UserDataServiceKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
