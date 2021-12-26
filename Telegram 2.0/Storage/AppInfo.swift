import Foundation
import KeychainSwift

class AppInfo: Codable {
    
    // MARK: - Properties
    static let shared = AppInfo()
    private static let keychain = KeychainSwift()
    
    var sessionToken: String?
    var user: User? {
        didSet {
            save()
        }
    }
    
    // MARK: - Methods
    func save() {
        if let dataObject = try? JSONEncoder().encode(AppInfo.shared) {
            AppInfo.keychain.set(dataObject, forKey: "appInfo")
        }
    }
    
    func load() {
        if let data = AppInfo.keychain.getData("appInfo") {
            do {
                let info = try JSONDecoder().decode(AppInfo.self, from: data)
                sessionToken = info.sessionToken
                user = info.user
            } catch {}
        }
    }
    
    
    func clear() {
        sessionToken = nil
        user = nil
        save()
    }
    
  
}
