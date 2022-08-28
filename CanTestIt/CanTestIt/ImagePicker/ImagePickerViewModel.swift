import Foundation
import Combine
import UIKit

final class ImagePickerViewModel {
    @Published var data: [ImageCollectionSectionItem] = []
    @Published var isLoading = false

    private let imagesCache: EventImagesCache
    private let didChooseImage: (String) -> Void
    private let dismissView: () -> Void
    private var imagesCancellable: AnyCancellable?
    
    init(
        imagesCache: EventImagesCache,
        didChooseImage: @escaping (String) -> Void,
        dismissView: @escaping () -> Void
    ) {
        self.imagesCache = imagesCache
        self.didChooseImage = didChooseImage
        self.dismissView = dismissView
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
                        ImageCollectionSectionItem(name: $0)
                    }
                }
            )
    }
    
    func handleDidTapChooseButton(selectedPage: Int?) {
        guard let selectedPage = selectedPage else { return }
        
        didChooseImage(data[selectedPage].name)
        dismissView()
    }
}
