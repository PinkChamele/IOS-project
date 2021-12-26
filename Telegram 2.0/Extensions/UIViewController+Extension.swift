import UIKit

extension UIViewController {
    
    func showAlert(error: Error) {
        showAlert(text: error.localizedDescription, isSuccess: false)
    }
    
    func showAlert(text: String? = "", isSuccess: Bool = true) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        if window.viewWithTag(4191) != nil { return }
        
        let alertView = ToastView(text: text, isSuccess: isSuccess)
        alertView.tag = 4191
        window.addSubview(alertView)
        
        alertView.frame.size = .init(width: 200, height: 150)
        
        let xPos = window.center.x - (alertView.frame.width / 2)
        let yPos = window.center.y - (alertView.frame.height / 2)

        alertView.frame.origin = .init(x: xPos, y: yPos)
        
        alertView.alpha = 0
        window.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, delay: 0, animations: {
            alertView.alpha = 1
            window.layoutIfNeeded()
        }) { done in
            UIView.animate(withDuration: 0.25, delay: 2, animations: {
                alertView.alpha = 0
                window.layoutSubviews()
            }, completion: { done in
                alertView.removeFromSuperview()
            })
        }
    }
    
}
