import Foundation
import Combine

protocol EventImagesCache {
    func getImages() -> AnyPublisher<[String], Never>
}

final class EventImagesCacheImpl: EventImagesCache {
    private var downloadedImages: [String] = []
    private let imagesFetcher: ImagesAPIManagerFetcher
    
    init(imagesFetcher: ImagesAPIManagerFetcher) {
        self.imagesFetcher = imagesFetcher
    }
    
    func getImages() -> AnyPublisher<[String], Never> {
        guard downloadedImages.isEmpty else {
            return Just(downloadedImages).eraseToAnyPublisher()
        }
        
        return imagesFetcher.getImages()
            .catch({ [weak self] _ in
                return Just(self?.downloadedImages ?? [])
            })
            .flatMap({ [weak self] newValue -> AnyPublisher<[String], Never> in
                self?.downloadedImages = newValue
                
                return Just(self?.downloadedImages ?? []).eraseToAnyPublisher()
            }).eraseToAnyPublisher()
    }
}
