//
//  ConfigurableCell.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 26.01.2020.
//

import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

protocol CellConfigurator {
    static var reuseId: String { get }

    func configure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator
    where CellType.DataType == DataType, CellType: UITableViewCell {

    static var reuseId: String { String(describing: CellType.self) }

    let item: DataType

    init(item: DataType) {
        self.item = item
    }

    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}
