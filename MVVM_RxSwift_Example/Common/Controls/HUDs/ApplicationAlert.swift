//
//  ApplicationAlert.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import SVProgressHUD

private let delayTimeInterval: TimeInterval = 0.3

/// Alert implementation via simple SVProgressHUD. You can change it to any kind of Alert. Also u can customize it here
/// or create another Alert

final class ApplicationAlert: Alert {
    
    func show(on viewController: UIViewController, with style: AlertStyle, title: String?, message: String,
              actionTitle: String?) {
        /// Because we can't create SVProgressHUD instance we should always re-configure it befor show it
        /// because it would be overwritten every time
        configure()
        
        var delay: TimeInterval = 0
        if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
            delay = delayTimeInterval
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            SVProgressHUD.setDefaultMaskType(.none)
            self.showAlert(with: style, message: message)
        }
    }
    
    private func showAlert(with style: AlertStyle, message: String) {
        switch style {
        case .error:
            SVProgressHUD.showError(withStatus: message)
        case .success:
            SVProgressHUD.showSuccess(withStatus: message)
        case .info:
            SVProgressHUD.showInfo(withStatus: message)
        }
    }
    
    private func configure() {
        SVProgressHUD.setBackgroundColor(UIColor.lightGray.withAlphaComponent(0.5))
    }
    
}
