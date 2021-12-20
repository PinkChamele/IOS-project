import UIKit

extension UITableView {
    
    func dequeue<T: UITableViewCell>(cellForItemAt indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
    }
    
    func register(_ classNames: String...) {
        for name in classNames {
            self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        }
    }
}
