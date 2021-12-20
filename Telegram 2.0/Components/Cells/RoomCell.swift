import UIKit

class RoomCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        shadowView.addShadow(opacity: 0.09, yOffset: 4)
    }

    
}
