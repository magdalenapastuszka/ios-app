import Foundation
import Combine

protocol CategoriesAPIManagerFetcher {
    func getCategories() -> AnyPublisher<[Category], NetworkRequestError>
}

final class CategoriesAPIManager: CategoriesAPIManagerFetcher {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getCategories() -> AnyPublisher<[Category], NetworkRequestError> {
        apiClient.dispatch(GetCategoriesRequest())
    }
}
