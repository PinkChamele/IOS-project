import UIKit
import GrowingTextView

class RoomViewController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: GrowingTextView!
    
    let dataSource = RoomMessageListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.register(
            RoomMessageCell.className,
            OwnRoomMessageCell.className
        )

        messageField.delegate = self
        messageField.default()

    }
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        sender.rotate360Degrees()
    }
    
}

extension RoomViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
       UIView.animate(withDuration: 0.2) {
           self.view.layoutIfNeeded()
       }
    }
}
