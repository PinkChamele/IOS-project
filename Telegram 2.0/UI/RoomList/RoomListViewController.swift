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
    
    @IBAction func logoutAction(_ sender: Any) {
        authorizationService.logout { [weak self] _ in
            self?.navVC?.setRootVC(LoginViewController())
        } error: { [weak self]  error in
            self?.showAlert(text: error.localizedDescription, isSuccess: false)
        }
    }
    
    @IBAction func createRoomAction(_ sender: Any) {
        showCreateRoomAlert()
    }
    
    @IBAction func joinRoomAction(_ sender: Any) {
        showJoinRoomAlert()
    }
    
    func showCreateRoomAlert() {
        let alert = UIAlertController(
            title: "New room".localized,
            message: "Enter room name".localized,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.text = ""
            textField.keyboardType = .emailAddress
            textField.tag = 2
            textField.autocapitalizationType = .none
        }
        
        alert.addAction(UIAlertAction(title: "tg.cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "Create".localized, style: .default, handler: { [weak alert] (_) in
            let name = alert?.textFields![0].text ?? ""
            self.roomsService.createRoom(name: name) { [self] rooms in
                updateRoomList(rooms: rooms ?? [])
            } error: { [self] error in
                showAlert(error: error)
            }

        }))
        
       present(alert, animated: true, completion: nil)
    }
    
    func showJoinRoomAlert() {
        let alert = UIAlertController(
            title: "Add room".localized,
            message: "Enter room id".localized,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.text = ""
            textField.keyboardType = .emailAddress
            textField.tag = 2
            textField.autocapitalizationType = .none
        }
        
        alert.addAction(UIAlertAction(title: "tg.cancel".localized, style: .cancel))
        alert.addAction(UIAlertAction(title: "Add".localized, style: .default, handler: { [weak alert] (_) in
            let id = alert?.textFields![0].text ?? ""
            self.roomsService.joinRoom(id: id) { [self] rooms in
                updateRoomList(rooms: rooms ?? [])
            } error: { [self] error in
                showAlert(error: error)
            }

        }))
        
       present(alert, animated: true, completion: nil)
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
