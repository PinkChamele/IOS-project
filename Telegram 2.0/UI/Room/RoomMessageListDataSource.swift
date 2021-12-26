import UIKit

class RoomMessageListDataSource: NSObject, UITableViewDataSource {
    
    var messages: [Message] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if (AppInfo.shared.user?.email == message.author) {
            let cell: OwnRoomMessageCell = tableView.dequeue(cellForItemAt: indexPath)
           cell.configure(with: message)
            return cell
        } else {
            let cell: RoomMessageCell = tableView.dequeue(cellForItemAt: indexPath)
            cell.configure(with: message)
            return cell
        }
    }
}
