import UIKit

class BaseController: UIViewController {
    
    var navVC: BaseNavigationController? {
        return navigationController as? BaseNavigationController
    }
    
    func present(_ vc: UIViewController, animated: Bool = true) {
        present(vc, animated: animated)
    }
    
    func pushController(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func popController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}
