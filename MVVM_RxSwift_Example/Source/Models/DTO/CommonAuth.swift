//
//  CommonAuth.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

struct CommonAuth: Decodable {
    
    public let auth: Authentication
    public let user: ProfileExample
    
    public enum CodingKeys: String, CodingKey {
        case auth, user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        auth = try container.decode(Authentication.self, forKey: .auth)
        user = try container.decode(ProfileExample.self, forKey: .user)
    }
}
