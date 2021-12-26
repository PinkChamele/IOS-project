import SocketIO

struct Message {
    let id: String?
    let author: String?
    let room: String?
    let text: String?
    let createdAt: String?
    
    init (data: Any) {
        let message = data as? [String:Any]
        id = message?["_id"] as? String
        author = message?["author"] as? String
        room = message?["room"] as? String
        text = message?["text"] as? String
        createdAt = message?["createdAt"] as? String
    }
}
