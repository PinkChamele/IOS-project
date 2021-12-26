import Moya
import Alamofire

class RoomsApiService: BaseApiService<RoomsApi> {
    
    func userRooms(success successCallback: (([Room]?) -> Void)? = nil,
               error errorCallback: ((Error) -> Void)? = nil) {
        api.request(.userRooms) { result in
            switch result {
            case .success(let response):
                let responseData = try? response.map([Room].self)
                successCallback?(responseData)
            case .failure(let error):
                errorCallback?(error)
                print(error.localizedDescription)
            }
        }
    }
}

