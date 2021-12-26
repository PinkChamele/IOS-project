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

extension UITableView {

    func scrollToBottom(isAnimated:Bool = true){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }

    func scrollToTop(isAnimated:Bool = true) {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
           }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
