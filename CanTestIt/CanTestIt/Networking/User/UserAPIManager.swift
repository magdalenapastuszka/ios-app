import Combine

protocol UserAPIManager {
    func login(login: String, password: String) -> AnyPublisher<String, NetworkRequestError>
}

final class UserAPIManagerImpl: UserAPIManager {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func login(login: String, password: String) -> AnyPublisher<String, NetworkRequestError> {
        apiClient.dispatch(LoginRequest(bodyModel: .init(login: login, password: password)))
    }
}
