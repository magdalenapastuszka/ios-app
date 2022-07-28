import Foundation

final class ImagePickerViewModel {
    @Published var data: [ImageCollectionData] = [
        .init(
            key: .main,
            values: [
                .main(.image1),
                .main(.image2),
                .main(.image3),
                .main(.image4)
            ])
    ]

    func loadModel() -> ImagePickerView.Model {
        ImagePickerView.Model(buttonTitle: "image-picker.button-title".localized)
    }
    
    func handleDidTapChooseButton(selectedPage: Int?) {
        
    }
}
