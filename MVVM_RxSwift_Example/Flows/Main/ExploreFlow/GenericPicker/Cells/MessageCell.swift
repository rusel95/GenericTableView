//
//  MessageTableViewCell.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 26.01.2020.
//  Copyright © 2020 Buyper. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, ConfigurableCell {

    @IBOutlet private weak var messageLabel: UILabel!

    func configure(data message: String) {
        messageLabel.text = message
    }
    
}
