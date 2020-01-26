//
//  SettingsModel.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class OrdrersModel: EventNode, HasDisposeBag {
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    private func initializeBindings() {

    }
    
    // MARK: - private
    
}
