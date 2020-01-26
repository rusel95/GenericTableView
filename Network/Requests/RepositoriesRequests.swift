//  GetReposRequest.swift
//  ArchitectureGuideTemplate
//
//  Created by Serhii Butenko on 17/10/16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import APIClient

public struct GetRepositoriesRequest: SerializeableAPIRequest, DecoratableRequest {
    
    public let path = "repositories"
    public let parser = MappableArrayParser<[Repository]>()
    public private(set) var parameters: [String: Any]?
    
    var authRequired = false
    
    public init(since repositoryID: String? = nil) {
        if let repositoryID = repositoryID {
            parameters = ["since": repositoryID]
        }
    }
}

struct GetRepositoryDetailsRequest: SerializeableAPIRequest {
    
    let path: String
    let parser = MappableParser<Repository>()
    
    init(repository: Repository) {
        path = "repos/" + repository.fullName
    }
}

struct StarRepositoryRequest: SerializeableAPIRequest {
    
    let method: APIRequestMethod = .put
    let path: String
    let parser = EmptyParser()
    
    init(repository: Repository) {
        path = "user/starred/" + repository.fullName
    }
}

struct UnstarRepositoryRequest: SerializeableAPIRequest {
    
    let method: APIRequestMethod = .delete
    let path: String
    let parser = EmptyParser()
    
    init(repository: Repository) {
        path = "user/starred/" + repository.fullName
    }
}
