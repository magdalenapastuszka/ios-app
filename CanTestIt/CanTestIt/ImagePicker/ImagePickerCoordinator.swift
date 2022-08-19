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
    
    func start() {
        let vc = ImagePickerViewController(
            viewModel: ImagePickerViewModel(imagesCache: appEngine.eventImagesCache))
        vc.configureGoBackNav()
        navigationController.go(to: vc, as: .push)
    }
}
