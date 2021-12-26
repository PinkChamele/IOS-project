import UIKit

class RoomListViewController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = RoomListDataSource()
    let roomsService = RoomsApiService()

    let authorizationService = AuthorizationApiService()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(RoomCell.className)
        loadRooms()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func addRoomAction(_ sender: Any) {
        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        authorizationService.logout { [weak self] _ in
            self?.navVC?.setRootVC(LoginViewController())
        } error: { [weak self]  error in
            self?.showAlert(text: error.localizedDescription, isSuccess: false)
        }
    }
    
    func loadRooms() {
        roomsService.userRooms { [weak self] rooms in
            self?.updateRoomList(rooms: rooms ?? [])
        } error: { [weak self] error in
            self?.showAlert(error: error)
        }
    }
    
    func updateRoomList(rooms: [Room]) {
        dataSource.rooms = rooms
        tableView.reloadData()
    }
}

extension RoomListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let room = dataSource.rooms[indexPath.row]
        pushController(RoomViewController(room: room))
    }
}
