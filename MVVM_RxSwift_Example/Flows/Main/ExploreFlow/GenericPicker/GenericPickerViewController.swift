//
//  GenericPickerViewController.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 26.01.2020.
//  Copyright © 2020 Buyper. All rights reserved.
//

import UIKit

class GenericPickerViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    internal let viewModel = GanericTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        tableView.reloadData()
    }

}

extension GenericPickerViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

}

// MARK: - Private configuration
private extension GenericPickerViewController {

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
    }
}
