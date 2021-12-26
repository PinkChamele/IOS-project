import UIKit
import GrowingTextView

class RoomViewController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageField: GrowingTextView!
    @IBOutlet weak var messageControllsContainer: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let socketService = SocketService()
    let authorizationService = AuthorizationApiService()
    
    let dataSource = RoomMessageListDataSource()
    
    let room: Room

    init(room: Room) {
        self.room = room
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.register(
            RoomMessageCell.className,
            OwnRoomMessageCell.className
        )
        titleLabel.text = room.name
        
        messageField.delegate = self
        messageField.default()
        socketService.connectionCreated = {
            self.addHandlers()
        }
        socketService.connect()
        updateSendButtonVisability()
    }
    
    func addHandlers() {
        socketService.handleMessage { data in
            self.gotMessage(message: data)
        }
        socketService.handleAllMessages(roomId: room.id) { data in
            self.gotAllMessages(messages: data)
        }
    }
    
    func gotMessage(message: Message) {
        dataSource.messages.append(message)
        tableView.reloadData()
        tableView.scrollToBottom()
    }
    
    func gotAllMessages(messages: [Message]) {
        dataSource.messages = messages
        tableView.reloadData()
        if messages.count > 0 {
            tableView.scrollToBottom(isAnimated: false)
        }
    }
    
    func updateSendButtonVisability() {
        do {
            try messageField.text.validated(of: .message)
            sendButton.superview?.hideAnimated(in: messageControllsContainer, isHidden: false)
            sendButton.isHidden = false
        } catch {
            sendButton.superview?.hideAnimated(in: messageControllsContainer, isHidden: true)
            sendButton.isHidden = true
        }
    }
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        socketService.sendMessage(message: .init(
            text: messageField.text,
            author: AppInfo.shared.user?.email ?? "",
            roomId: room.id
        ))
        messageField.text = ""
        sender.rotate360Degrees()
    }
    
    @IBAction func backAction(_ sender: Any) {
        popController()
    }
}

extension RoomViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
       UIView.animate(withDuration: 0.2) {
           self.view.layoutIfNeeded()
       }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSendButtonVisability()
    }
}
