//
//  DecoratableRequest.swift
//  ArchitectureGuideTemplate
//
//  Created by Roman Kyrylenko on 1/24/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation

protocol DecoratableRequest {
    
    var authRequired: Bool { get }
    
}

extension DecoratableRequest {
    
    var authRequired: Bool { return false }
    
}
