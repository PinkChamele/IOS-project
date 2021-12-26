import UIKit
import SnapKit

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
        
        alertView.snp.makeConstraints { make in
            make.center.equalTo(window.center)
            make.width.equalTo(200)
            make.height.lessThanOrEqualTo(500)
        }
        
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
