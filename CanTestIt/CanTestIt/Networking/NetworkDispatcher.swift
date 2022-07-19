import Combine
import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
}

struct NetworkDispatcher {
    let urlSession: URLSession!
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func dispatch<ReturnType: Codable>(request: URLRequest, decoder: JSONDecoder?) -> AnyPublisher<ReturnType, NetworkRequestError> {

        let decoder = decoder ?? JSONDecoder()

        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse,
                 !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                return data
            })
            .decode(type: ReturnType.self, decoder: decoder)
            .mapError { error in
               handleError(error)
            }
            .eraseToAnyPublisher()
    }
    
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
            case 400: return .badRequest
            case 401: return .unauthorized
            case 403: return .forbidden
            case 404: return .notFound
            case 402, 405...499: return .error4xx(statusCode)
            case 500: return .serverError
            case 501...599: return .error5xx(statusCode)
            default: return .unknownError
        }
    }
    
    private func handleError(_ error: Error) -> NetworkRequestError {
        print(error)
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
    
    private func debugMessage(_ message: String) {
        #if DEBUG
        Logger.other("")
        #endif
    }
}
