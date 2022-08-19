import Foundation
import Combine
import UIKit

final class ImagePickerViewModel {
    @Published var data: [ImageCollectionSectionItem] = []
    @Published var isLoading = false

    private let imagesCache: EventImagesCache
    private var imagesCancellable: AnyCancellable?
    
    init(imagesCache: EventImagesCache) {
        self.imagesCache = imagesCache
    }
    
    func loadModel() -> ImagePickerView.Model {
        ImagePickerView.Model(buttonTitle: "image-picker.button-title".localized)
    }
    
    func loadImages() {
        isLoading = true
        imagesCancellable = imagesCache.getImages()
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                },
                receiveValue: { [weak self] images in
                    self?.data = images.compactMap {
                        ImageCollectionSectionItem(image: UIImage(named: $0)!)
                    }
                }
            )
    }
    
    func handleDidTapChooseButton(selectedPage: Int?) {
        
    }
}
