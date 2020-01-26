//
//  UIViewController+RequestState.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import RxSwift

extension AlertPresentable where Self: UIViewController {
    
    func bind(requestState observable: Observable<RequestState>) {
        observable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.handle(state)
            })
            .disposed(by: disposeBag)
    }
    
    func handle(_ state: RequestState) {
        switch state {
        case .failed(let error):
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let error = error {
                alert.show(on: self, with: .error, title: nil, message: error.localizedDescription, actionTitle: nil)
            }

        case .inProgress:
            break

        case .started:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

        case .finished:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false

        case .success(let message):
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            alert.show(on: self, with: .success, title: nil, message: message ?? "", actionTitle: nil)

        }
    }
    
}
