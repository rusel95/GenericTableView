//
//  AuthenticationViewController.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class AuthenticationViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: AuthenticationViewModel! {
        didSet {
            //TODO: -
            //bind(requestState: viewModel.requestStateObservable)
        }
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Private Methods
    
    private func initializeBindings() {

    }
    
}
