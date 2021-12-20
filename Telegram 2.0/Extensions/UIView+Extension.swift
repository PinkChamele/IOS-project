import UIKit

extension UIView {
    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.06,
                   xOffset: CGFloat = 0,
                   yOffset: CGFloat = 4,
                   blur: CGFloat = 10,
                   spread: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: xOffset, height: yOffset)
        layer.shadowRadius = blur / 2
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

