import UIKit

class RoomListDataSource: NSObject, UITableViewDataSource {
    
    var rooms: [Room] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoomCell = tableView.dequeue(cellForItemAt: indexPath)
        let room = rooms[indexPath.row]
        cell.configure(with: room)
        return cell
    }
}
