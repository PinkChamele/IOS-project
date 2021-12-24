import UIKit

class RedirectManager {
    
    enum AppLink: String, CaseIterable {
        case resetPassword = "/reset-password"
    }
    
    @discardableResult
    class func redirectInternalLinks(url: URL) -> Bool {
        
        let path = url.path
        let parameters = url.queryDictionary
        
        guard let vcRoot = AppManager.rootNC,
              let appLink = getAppLink(path: path) else { return false }
        
        switch appLink {
        case .resetPassword:
            guard let token = parameters?["token"] else { return false }
            let vc = ResetPasswordViewController(token: token)
            vcRoot.present(vc, animated: true)
        }
        return true
    }
    
    class func getAppLink(path: String) -> AppLink? {
        if let appLinkEqual = AppLink.allCases.first(where: {path == $0.rawValue}) {
            return appLinkEqual
        } else if let appLinkContains = AppLink.allCases.first(where: {path.contains($0.rawValue)}) {
            return appLinkContains
        } else {
            return nil
        }
    }
    
}

