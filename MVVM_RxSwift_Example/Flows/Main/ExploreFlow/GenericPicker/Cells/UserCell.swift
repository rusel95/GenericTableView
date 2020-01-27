//
//  GenericTableViewCell.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 26.01.2020.
//  Copyright © 2020 Buyper. All rights reserved.
//

import UIKit
import Alamofire

class UserCell: UITableViewCell, ConfigurableCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!

    func configure(data user: User) {
        avatarImageView.setImage(with: user.avatarURL)
        userNameLabel.text = user.name
    }
    
}
