import UIKit

class RoomMessageListDataSource: NSObject, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell: RoomMessageCell = tableView.dequeue(cellForItemAt: indexPath)
            return cell
        } else {
            let cell: OwnRoomMessageCell = tableView.dequeue(cellForItemAt: indexPath)
            return cell
        }
    }
}
