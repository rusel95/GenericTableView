//
//  UIImageView+Kingfisher.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func setImage(with url: URL, placeholder: UIImage? = nil) {
        self.af_setImage(withURL: url, placeholderImage: placeholder)
    }
    
    func cancelImageFetching() {
        self.af_cancelImageRequest()
    }
}
