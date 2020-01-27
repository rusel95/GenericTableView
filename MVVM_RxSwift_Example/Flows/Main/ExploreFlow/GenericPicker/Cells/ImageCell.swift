//
//  ImageCellTableViewCell.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 26.01.2020.
//  Copyright © 2020 Buyper. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell, ConfigurableCell {

    @IBOutlet private weak var pictureView: UIImageView!

    func configure(data url: URL) {
        pictureView.setImage(with: url)
    }
    
}
