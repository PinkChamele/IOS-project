import Moya

enum AuthorizationApi {
    case register(data: AuthorizationRequest)
    case login(data: AuthorizationRequest)
    case logout
    case resetPassword(email: String)
    case confirmResetPassword(data: ConfirmResetPasswordRequest)
    case me
}

extension AuthorizationApi: TargetType {
    
    var baseURL: URL { return URL(string: Constants.baseURL)! }
    
    var path: String {
        switch self {
        case .login:
            return "/v1/auth/login"
        case .logout:
            return "/v1/auth/logout"
        case .register:
            return "/v1/auth/register"
        case .resetPassword:
            return "/v1/auth/send-reset-email"
        case .confirmResetPassword:
            return "/v1/auth/confirm-password-reset"
        case .me:
            return "v1/auth/self"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .logout, .register, .resetPassword, .confirmResetPassword:
            return .post
        case .me:
            return .get
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
        case let .login(data: data):
            return .requestJSONEncodable(data)
        case .register(data: let data):
            return .requestJSONEncodable(data)
        case .logout:
            return .requestPlain
        case .me:
            return .requestPlain
        case .resetPassword(email: let email):
            return .requestParameters(parameters: ["email":email], encoding: JSONEncoding.default)
        case .confirmResetPassword(data: let data):
            return .requestJSONEncodable(data)
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
