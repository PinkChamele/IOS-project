import UIKit
import GrowingTextView

class RoomViewController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageField: GrowingTextView!
    @IBOutlet weak var messageControllsContainer: UIStackView!
    
    let dataSource = RoomMessageListDataSource()
    let socketService = SocketService()
    let authorizationService = AuthorizationApiService()
    let room: Room
    var me: User?

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

        messageField.delegate = self
        messageField.default()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
        addHandlers()
        
    }
    
    func addHandlers() {
        socketService.handleMessage { data in
            self.gotMessage(message: data)
        }
        socketService.handleAllMessages(roomId: room.id) { data in
            self.gotAllMessages(messages: data)
        }
        socketService.connect()
    }
    
    func gotMessage(message: Message) {
        dataSource.messages.append(message)
        tableView.reloadData()
        tableView.scrollToBottom()
    }
    
    func gotAllMessages(messages: [Message]) {
        dataSource.messages = messages
        tableView.reloadData()
        tableView.scrollToBottom(isAnimated: false)
    }
    
    @objc func textDidChange(_ sender: UITextView) {
        do {
            try sender.text.validated(of: .message)
            sendButton.superview?.isHidden = false
        } catch {
            sendButton.superview?.isHidden = true
        }
        sendButton.hideAnimated(in: messageControllsContainer)
    }
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        socketService.sendMessage(message: .init(text: messageField.text, author: me?.email ?? "", roomId: room.id))
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
