//
//  TableViewModel.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 26.01.2020.
//  Copyright © 2020 Buyper. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let avatarURL: URL
}

typealias UserCellConfig = TableCellConfigurator<UserCell, User>
typealias MessageCellConfig = TableCellConfigurator<MessageCell, String>
typealias ImageCellConfig = TableCellConfigurator<ImageCell, URL>

class GanericTableViewModel {
    let items: [CellConfigurator] = [
        UserCellConfig.init(item:
            User(name: "Brad",
                 avatarURL: URL(string: "https://i2.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png?resize=256%2C256&quality=100&ssl=1")!)
        ),
        MessageCellConfig.init(item: "This is me!"),
        ImageCellConfig(item: URL(string: "https://picsum.photos/200/300/")!)
    ]
}
