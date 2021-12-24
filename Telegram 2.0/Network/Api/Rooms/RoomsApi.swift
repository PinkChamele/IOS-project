import Moya

enum RoomsApi {
    case rooms
    case userRooms
    case joinRoom(data: JoinRoomRequest)
    case createRoom(data: CreateRoomRequest)
    case roomById(id: String)
}

extension RoomsApi: TargetType {
    
    var baseURL: URL { return URL(string: Constants.baseURL)! }
    
    var path: String {
        switch self {
        case .rooms:
            return "/v1/rooms"
        case .userRooms:
            return "/v1/rooms/getAllByUser"
        case .joinRoom:
            return "/v1/rooms/join"
        case .createRoom:
            return "/v1/rooms"
        case .roomById:
            return "/v1/rooms"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .rooms, .userRooms, .roomById:
            return .get
        case .joinRoom, .createRoom:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "Half measures are as bad as nothing at all.".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .rooms, .userRooms:
            return .requestPlain
        case .joinRoom(data: let data):
            return .requestJSONEncodable(data)
        case .createRoom(data: let data):
            return .requestJSONEncodable(data)
        case .roomById(id: let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ["Accept": "application/json",
         "Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
