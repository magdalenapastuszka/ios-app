import Foundation
import Combine

protocol ImagesAPIManagerFetcher {
    func getImages() -> AnyPublisher<[String], NetworkRequestError>
}

final class ImagesAPIManager: ImagesAPIManagerFetcher {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClient(baseURL: AppVariables.baseURL)) {
        self.apiClient = apiClient
    }
    
    func getImages() -> AnyPublisher<[String], NetworkRequestError> {
        apiClient.dispatch(GetImagesRequest())
    }
}
