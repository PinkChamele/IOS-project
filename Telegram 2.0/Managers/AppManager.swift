import Foundation
import UIKit
import IQKeyboardManagerSwift

struct AppManager {
        
    static func configureRootVC(in window: UIWindow?) {
        prepare()
       
        
        let rootVC: UIViewController
        
        if AppInfo.shared.sessionToken == nil {
            rootVC = LoginViewController()
        } else {
            rootVC = RoomListViewController()
        }
        
        let nc = BaseNavigationController(rootViewController: rootVC)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
    
    private static func prepare() {
        IQKeyboardManager.shared.enable = true
        AppInfo.shared.load()
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }

}
