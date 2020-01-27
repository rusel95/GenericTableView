//
//  ContollerFactory.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 27.01.2020.
//

import UIKit

class ControllerFactory {

    static func createViewController<T: UIViewController>() -> T {
        let nameStoryboard = String(describing: T.self)
        let nameViewController = String(describing: T.self)
        let newVC = UIStoryboard(name: nameStoryboard, bundle: nil).instantiateViewController(withIdentifier: nameViewController)
        guard let viewController = newVC as? T else { fatalError() }

        return viewController
    }
}
