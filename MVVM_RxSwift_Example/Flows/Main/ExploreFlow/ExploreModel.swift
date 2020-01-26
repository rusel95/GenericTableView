//
//  TimerModel.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRealm

final class ExploreModel: EventNode, HasDisposeBag {
    
    private var timer = Timer()
    private var isTimerWorking = false
    
    override init(parent: EventNode) {
        super.init(parent: parent)
        
        addHandlers()
        initializeBindings()
    }
    
    private func initializeBindings() {

    }
    
    // MARK: - private
    private func addHandlers() {
//        addHandler { [unowned self] (event: ApplicationEvent) in
//            switch event {
//            case .applicationDidEnterBackground:
//                self.pauseWhenBackround()
//            case .applicationWillEnterForeground:
//                self.willEnterForeground()
//            }
//        }
    }
}
