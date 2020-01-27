//
// ExploreModel.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import RxSwift
import RxCocoa
import RxRealm

enum ChooseObjectEvent: Event {
    case newLikes(count: Int)
}

final class ExploreModel: EventNode, HasDisposeBag {

    let goToChooseObjectAction = PublishSubject<Void>()

    override init(parent: EventNode) {
        super.init(parent: parent)
        
        addHandlers()
        initializeBindings()
    }
    
    private func initializeBindings() {
        goToChooseObjectAction
            .doOnNext { [weak self] _ in
                self?.raise(event: ExploreNavigationEvent.selectObjectFrom(items: []))
            }.disposed(by: disposeBag)
    }
    
    // MARK: - private
    private func addHandlers() {
        addHandler { [unowned self] (event: ChooseObjectEvent) in
//            switch event {
//            case .applicationDidEnterBackground:
//                self.pauseWhenBackround()
//            case .applicationWillEnterForeground:
//                self.willEnterForeground()
//            }
        }
    }
}
