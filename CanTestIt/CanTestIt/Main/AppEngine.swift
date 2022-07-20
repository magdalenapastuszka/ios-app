import Foundation

protocol AppEngine {
    var apiClient: APIClient { get set }
}

struct AppVariables {
    static let baseURL = ""
}

final class AppEngineImpl: AppEngine {
    lazy var apiClient: APIClient = APIClient(baseURL: AppVariables.baseURL)
}
