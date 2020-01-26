import UIKit

enum AlertStyle {
    
    case error, success, info
    
}

protocol Alert {
    
    /**
     - parameter viewController: `UIViewController` on which Alert should be shown
     - parameter style: `AlertStyle` of Alert
     - parameter message: Message to show
     - parameter title: Optional title of Alert
     - parameter actionTitle: Optional Title of Button in Alert if it exists
     */
    
    func show(on viewController: UIViewController,
              with style: AlertStyle,
              title: String?,
              message: String,
              actionTitle: String?)
    
}
