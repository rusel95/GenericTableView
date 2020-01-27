//
//  TimerViewController.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class  ExploreViewController: UIViewController {

    @IBOutlet private weak var chooseObjectButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    var viewModel: ExploreViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        chooseObjectButton.rx.tap
            .bind(to: viewModel.goToChooseObjectAction)
            .disposed(by: disposeBag)
    }
    
}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
