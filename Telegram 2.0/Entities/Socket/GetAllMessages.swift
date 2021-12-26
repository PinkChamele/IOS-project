import SocketIO

struct GetAllMessages : SocketData {
   let roomId: String

   func socketRepresentation() -> SocketData {
       return ["room": roomId]
   }
}
