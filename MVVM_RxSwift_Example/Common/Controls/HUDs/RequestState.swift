//
//  RequestState.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation

enum RequestState {
    
    case started // start spinner
    case inProgress(Float) // display progress view
    case finished // stop spinner
    case failed(Error?) // display error
    case success(String?) // display success
    
}
