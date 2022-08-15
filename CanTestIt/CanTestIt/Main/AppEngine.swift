import Foundation

protocol AppEngine {
    var apiClient: APIClient { get }
    var userDefaultsManager: UserDefaultsMenager { get }
    var categoriesCache: CategoriesCache { get }
    var eventImagesCache: EventImagesCache { get }
}

final class AppEngineImpl: AppEngine {
    lazy var apiClient: APIClient = APIClient(baseURL: AppVariables.baseURL)
    lazy var userDefaultsManager: UserDefaultsMenager = UserDefaultsMenagerImpl()
    lazy var categoriesCache: CategoriesCache = CategoriesCacheImpl(
        categoriesFetcher: CategoriesAPIManager(apiClient: apiClient)
    )
    lazy var eventImagesCache: EventImagesCache = EventImagesCacheImpl(
        imagesFetcher: ImagesAPIManager(apiClient: apiClient)
    )
}
