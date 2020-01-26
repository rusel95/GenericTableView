//
//  UserRequests.swift
//  ArchitectureGuideTemplate
//
//  Created by Artem Havriushov on 10/20/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import APIClient

struct GetUserRequest: SerializeableAPIRequest, DecoratableRequest {

    let method: APIRequestMethod = .get
    let path = "user"
    let parser = MappableParser<User>()
    let authRequired: Bool = true
    
}

struct UpdateUserRequest: SerializeableAPIRequest, DecoratableRequest {
    
    let method: APIRequestMethod = .patch
    let path = "user"
    let parser = MappableParser<User>()
    let authRequired: Bool = true
    private(set) var parameters: [String: Any]?
    
    init(user: User) {
        parameters = user.toJSON()
    }
}
