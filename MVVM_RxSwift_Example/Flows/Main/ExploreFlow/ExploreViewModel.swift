//
//  TimerViewModel.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift

final class ExploreViewModel: HasDisposeBag {
    
    var goToChooseObjectAction: PublishSubject<Void> {
        return model.goToChooseObjectAction
    }

    private let model: ExploreModel
    
    init(model: ExploreModel) {
        self.model = model
    }
    
}
