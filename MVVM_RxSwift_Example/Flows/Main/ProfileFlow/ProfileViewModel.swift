//
//  ProfileViewModel.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/29/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift

final class ProfileViewModel: HasDisposeBag {
    
    private let model: ProfileModel
    
    init(model: ProfileModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
}
