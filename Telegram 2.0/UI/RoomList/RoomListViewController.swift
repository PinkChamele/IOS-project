import UIKit

class RoomListViewController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = RoomListDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
        tableView.register(RoomCell.className)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }

}
