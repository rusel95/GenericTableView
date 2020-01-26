//
//  SettingsViewModel.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift

final class MapViewModel: HasDisposeBag {
    
    private let model: MapModel
    
    init(model: MapModel) {
        self.model = model
        initializeBindings()
    }
    
    private func initializeBindings() {
        
    }
    
}
