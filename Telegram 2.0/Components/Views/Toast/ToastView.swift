import UIKit

class ToastView: LoadingNib {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    convenience init(text: String? = "Зміни збережено", isSuccess: Bool = true) {
        self.init()
        
        containerView.addShadow()
        imageView.image = #imageLiteral(resourceName: "pop-it")
        imageView.tintColor = isSuccess ? .green : .red
        titleLabel.text = text

    }
}
