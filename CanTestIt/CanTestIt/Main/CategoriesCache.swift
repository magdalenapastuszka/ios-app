import Foundation
import Combine

protocol CategoriesCache {
    func fetchCategories() -> AnyPublisher<[Category], Never>
}

final class CategoriesCacheImpl: CategoriesCache {
    private var downloadedCategories: [Category] = []
    private let categoriesFetcher: CategoriesAPIManagerFetcher
    
    init(categoriesFetcher: CategoriesAPIManagerFetcher) {
        self.categoriesFetcher = categoriesFetcher
    }
    
    func fetchCategories() -> AnyPublisher<[Category], Never> {
        guard downloadedCategories.isEmpty else {
            return Just(downloadedCategories).eraseToAnyPublisher()
        }
        
        return categoriesFetcher.getCategories()
            .catch({ [weak self] _ in
                return Just(self?.downloadedCategories ?? [])
            })
            .flatMap({ [weak self] newValue -> AnyPublisher<[Category], Never> in
                self?.downloadedCategories = newValue
                
                return Just(self?.downloadedCategories ?? []).eraseToAnyPublisher()
            }).eraseToAnyPublisher()
    }
}
