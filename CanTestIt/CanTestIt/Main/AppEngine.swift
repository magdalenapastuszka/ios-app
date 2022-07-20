import Foundation

protocol AppEngine {
    var apiClient: APIClient { get }
    var userDefaultsManager: UserDefaultsMenager { get }
}

struct AppVariables {
    static let baseURL = ""
}

final class AppEngineImpl: AppEngine {
    lazy var apiClient: APIClient = APIClient(baseURL: AppVariables.baseURL)
    lazy var userDefaultsManager: UserDefaultsMenager = UserDefaultsMenagerImpl()
}
