//
//  Profile.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Realm
import RealmSwift

public class ProfileExample: Object, Decodable {
    
    public var isUnregistered: Bool {
        return email.isEmpty
    }
    
    @objc public dynamic var identifier: Int = -1
    @objc public dynamic var email: String = ""
    @objc public dynamic var username: String = ""
    
    public enum CodingKeys: String, CodingKey {
        case idendifier, email, username
    }
    
    convenience init(identifier: Int, email: String, username: String) {
        self.init()
        
        self.identifier = identifier
        self.email = email
        self.username = username
    }
    
    convenience required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let identifier = try container.decode(Int.self, forKey: .idendifier)
        let email = try container.decode(String.self, forKey: .email)
        let username = try container.decode(String.self, forKey: .username)
        
        self.init(identifier: identifier,
                  email: email,
                  username: username)
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    public override static func primaryKey() -> String? {
        return CodingKeys.idendifier.rawValue
    }
    
}
