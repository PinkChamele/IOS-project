import Foundation
import Moya

class BaseApiService<T> where T: TargetType {
    
    var api: MoyaProvider<T>!
    
    required init() {
        let requestClosure = { (endpoint: Endpoint, closure: @escaping MoyaProvider.RequestResultClosure) in
                do {
                    let urlRequest = try endpoint.urlRequest()
                    closure(.success(urlRequest))
                } catch MoyaError.requestMapping(let url) {
                    closure(.failure(MoyaError.requestMapping(url)))
                } catch MoyaError.parameterEncoding(let error) {
                    closure(.failure(MoyaError.parameterEncoding(error)))
                } catch {
                    closure(.failure(MoyaError.underlying(error, nil)))
                }
        }
        api = MoyaProvider<T>(requestClosure: requestClosure, plugins: [NetworkLoggerPlugin(configuration: Self.apiConfiguration())])
    }

    private class func apiConfiguration() -> NetworkLoggerPlugin.Configuration {
        let apiConfiguration =  NetworkLoggerPlugin.Configuration(
            formatter: NetworkLoggerPlugin.Configuration.Formatter(),
            output: { (t, s) in
                NetworkLoggerPlugin.Configuration.defaultOutput(target: t, items: s)
            },
            logOptions: [.verbose]
        )
        return apiConfiguration
    }
    
}
