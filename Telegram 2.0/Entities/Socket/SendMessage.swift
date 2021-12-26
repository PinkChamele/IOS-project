import SocketIO

struct SendMessage : SocketData {
   let text: String
    let author: String
    let roomId: String

   func socketRepresentation() -> SocketData {
       return ["room": roomId, "text": text, "author": author]
   }
}
