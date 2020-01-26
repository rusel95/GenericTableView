//
//  Authentication.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

public struct Authentication: Tokenable, Decodable {
    
    public var accessToken: String?
    public var exchangeToken: String?
    
}
