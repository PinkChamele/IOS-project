import UIKit

class RoomCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var roomAvatarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        shadowView.addShadow(opacity: 0.09, yOffset: 4)
    }

    func configure(with room: Room) {
        titleLabel.text = room.name
        roomAvatarLabel.text = "\(room.name.first ?? .init("💩"))"
    }
}
