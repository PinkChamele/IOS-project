import Moya
import Alamofire

class AuthorizationApiService: BaseApiService<AuthorizationApi> {
    
    func login(data: AuthorizationRequest,
               success successCallback: ((Data?) -> Void)? = nil,
               error errorCallback: ((Error) -> Void)? = nil) {
        api.request(.login(data: data)) { result in
            switch result {
            case .success(let response):
                let responseData = try? response.map(Data.self)
                successCallback?(responseData)
            case .failure(let error):
                errorCallback?(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func logout(success successCallback: ((Data?) -> Void)? = nil,
                error errorCallback: ((Error) -> Void)? = nil) {
        api.request(.logout) { result in
            switch result {
            case .success(let response):
                let responseData = try? response.map(Data.self)
                successCallback?(responseData)
            case .failure(let error):
                errorCallback?(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func register(data: AuthorizationRequest,
                  success successCallback: ((Data?) -> Void)? = nil,
                  error errorCallback: ((Error) -> Void)? = nil) {
        api.request(.register(data: data)) { result in
            switch result {
            case .success(let response):
                print(response.response?.allHeaderFields["Set-Cookie"])
                let responseData = try? response.map(Data.self)
                successCallback?(responseData)
            case .failure(let error):
                errorCallback?(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func resetPassword(email: String,
                       success successCallback: ((Data?) -> Void)? = nil,
                       error errorCallback: ((Error) -> Void)? = nil) {
        api.request(.resetPassword(email: email)) { result in
            switch result {
            case .success(let response):
                let responseData = try? response.map(Data.self)
                successCallback?(responseData)
            case .failure(let error):
                errorCallback?(error)
                print(error.localizedDescription)
            }
        }
    }
    
    func confirmResetPassword(data: ConfirmResetPasswordRequest,
                              success successCallback: ((Data?) -> Void)?,
                              error errorCallback: ((Error) -> Void)? = nil) {
        api.request(.confirmResetPassword(data: data)) { result in
            switch result {
            case .success(let response):
                let responseData = try? response.map(Data.self)
                successCallback?(responseData)
            case .failure(let error):
                errorCallback?(error)
                print(error.localizedDescription)
            }
        }
    }
}
