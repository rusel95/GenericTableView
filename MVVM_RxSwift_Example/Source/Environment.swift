//
//  Environment.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation

public struct Environment: Codable {
    
    public var name: String
    public var serverUrl: String
    public var socketUrl: String
    public var pagesUrl: String
}

extension Environment {
    
    public static let `default` = Environment(named: "Environment")!
    
    public init?(named name: String = "undefined", in bundle: Bundle = .main) {
        if
            let url = Bundle.main.url(forResource: name, withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let value = try? PropertyListDecoder().decode(Environment.self, from: data)
        {
            self = value
        } else {
            return nil
        }
    }
}
