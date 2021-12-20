import UIKit

class BaseNavigationController: UINavigationController {
    
    func setRootVC(_ vc: UIViewController, animated: Bool = true) {
        setViewControllers([vc], animated: animated)
    }
}
