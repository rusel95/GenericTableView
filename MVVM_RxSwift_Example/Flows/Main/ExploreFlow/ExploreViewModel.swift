//
//  TimerViewModel.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift

final class ExploreViewModel: HasDisposeBag {
    
//    var settingsButtonTapped: PublishSubject<Void> {
//        return model.settingsAction
//    }
//    
//    var statisticButtonTapped: PublishSubject<Void> {
//        return model.statisticAction
//    }
//    
//    var startButtonTapped: PublishSubject<Void> {
//        return model.startCountdownAction
//    }
//    
//    var pauseButtonTapped: PublishSubject<Void> {
//        return model.pauseCountdownAction
//    }
//    
//    var stopButtonTapped: PublishSubject<Void> {
//        return model.stopCountdownAction
//    }

    private let model: ExploreModel
    
    init(model: ExploreModel) {
        self.model = model
    }
    
}
