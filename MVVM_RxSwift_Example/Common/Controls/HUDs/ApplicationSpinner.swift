//
//  ApplicationSpinner.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import SVProgressHUD

/// Spinner implementation via SVProgressHUD. You can change it to any kind of Spinner. Also u can customize it here
/// or create another Spinner

final class ApplicationSpinner: Spinner {
    
    func show(on view: UIView, text: String?, blockUI: Bool) {
        /// Because we can't create SVProgressHUD instance we should always re-configure it befor show it
        /// because it would be overwritten every time
        configure()
        SVProgressHUD.setDefaultMaskType(blockUI ? .clear : .none)
        
        if let text = text {
           SVProgressHUD.show(withStatus: text)
        } else {
            SVProgressHUD.show()
        }
    }
    
    func hide(from view: UIView) {
        SVProgressHUD.dismiss()
    }
    
    private func configure() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.lightGray.withAlphaComponent(0.5))
    }
    
}
