import UIKit

final class EventFormCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var event: Event?
    
    private lazy var imagePickerCoordinator = ImagePickerCoordiantor(
        navigationController: navigationController,
        appEngine: appEngine
    )
    
    private let appEngine: AppEngine
    
    init(
        navigationController: UINavigationController,
        appEngine: AppEngine
    ) {
        self.navigationController = navigationController
        self.appEngine = appEngine
    }
    
    func start(isDeleteButtonHidden: Bool) {
        let vc = EventFormViewController(viewModel: EventFormViewModel(
            event: event,
            categoriesCache: appEngine.categoriesCache,
            eventsCreator: appEngine.eventsCreator,
            isDeleteButtonHidden: isDeleteButtonHidden,
            showImagePicker: showImagePicker,
            dismissView: dismissView
        ))
        vc.configureGoBackNav()
        navigationController.go(to: vc, as: .push)
    }
    
    private func dismissView() {
        navigationController.dismiss(animated: true)
    }
    
    private func showImagePicker(didChooseImage: @escaping (String) -> Void) {
        imagePickerCoordinator.start(didChooseImage: didChooseImage)
    }
}
