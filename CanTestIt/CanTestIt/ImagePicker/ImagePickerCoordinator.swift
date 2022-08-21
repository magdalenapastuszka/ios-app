import UIKit

final class ImagePickerCoordiantor: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let appEngine: AppEngine
    
    init(
        navigationController: UINavigationController,
        appEngine: AppEngine
    ) {
        self.navigationController = navigationController
        self.appEngine = appEngine
    }
    
    func start(didChooseImage: @escaping (UIImage) -> Void) {
        let vc = ImagePickerViewController(
            viewModel: ImagePickerViewModel(
                imagesCache: appEngine.eventImagesCache,
                didChooseImage: didChooseImage,
                dismissView: dismissView
            ))
        vc.configureCloseNav()
        navigationController.go(to: vc, as: .modal)
    }
    
    private func dismissView() {
        navigationController.dismiss(animated: true)
    }
}
