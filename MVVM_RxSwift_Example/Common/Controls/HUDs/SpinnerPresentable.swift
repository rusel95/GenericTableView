import UIKit

protocol SpinnerPresentable {
    
    var spinner: Spinner { get }
    
    func showSpinner(with text: String?, blockUI: Bool)
    func hideSpinner()
    
}

extension SpinnerPresentable where Self: UIViewController {
    
    func showSpinner(with text: String? = nil, blockUI: Bool = true) {
        spinner.show(on: view, text: text, blockUI: blockUI)
    }
    
    func hideSpinner() {
        spinner.hide(from: view)
    }
    
}
