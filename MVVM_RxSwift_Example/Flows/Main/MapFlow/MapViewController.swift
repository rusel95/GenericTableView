//
//  SettingsViewController.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 11/29/18.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var container: UIView!
    
    var viewModel: MapViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    // MARK: - Private Methods
    private func initializeBindings() {
        
    }

}
