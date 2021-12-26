import SocketIO

class SocketService {
    let manager: SocketManager
    let socket: SocketIOClient
    
    var connectionCreated: ()->() = {}
    var connectionClosed: ()->() = {}

    var connected = false {
        didSet {
            if connected {
                connectionCreated()
            } else {
                connectionClosed()
            }
        }
    }

    init() {
        manager = SocketManager(socketURL: URL(string: Constants.baseURL)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
    }
    
    func connect() {
        socket.on("connect") { (data, ack) -> Void in
            print("socket connected")
        }
        socket.connect()
    }
    
    func handleMessage(handler: @escaping ((Message) -> Void)) {
        socket.on("message") {data, ack in
            handler(Message(data: data[0]))
        }
    }
    
    func sendMessage(message: SendMessage) {
        socket.emit("sendMessage", message)
    }
    
    func getAllMessages(roomId: String) {
        socket.emit("getAllMessages", ["room": roomId])
    }
    
    func handleAllMessages(roomId: String, handler: @escaping (([Message]) -> Void)) {
        socket.on("allMessages") { data, ack in
            let messages = (data.first as? [Any])?.map({ Message(data: $0) }) ?? []
            handler(messages)
        }
        getAllMessages(roomId: roomId)
    }
}
