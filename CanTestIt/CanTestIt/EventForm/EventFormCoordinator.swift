import UIKit
import UIMagicDropDown
import Combine

final class EventFormCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var event: Event?
    
    private lazy var imagePickerCoordinator = ImagePickerCoordiantor(
        navigationController: navigationController,
        appEngine: appEngine
    )
    
    private var categories: [Category] = []
    private var cancellable: AnyCancellable?
    private let appEngine: AppEngine
    
    init(
        navigationController: UINavigationController,
        appEngine: AppEngine
    ) {
        self.navigationController = navigationController
        self.appEngine = appEngine
        getCategories()
    }
    
    func start(isDeleteButtonHidden: Bool) {
        let vc = EventFormViewController(viewModel: EventFormViewModel(
            event: event,
            categories: categories,
            eventFormAPIManager: appEngine.eventsAPIManager,
            isDeleteButtonHidden: isDeleteButtonHidden,
            showImagePicker: showImagePicker,
            dismissView: dismissView
        ))
        vc.configureGoBackNav()
        navigationController.go(to: vc, as: .push)
    }
    
    private func getCategories() {
        cancellable = appEngine.categoriesCache.fetchCategories()
            .sink {[weak self] categories in
                self?.categories = categories
            }
    }
    
    private func dismissView() {
        navigationController.dismiss(animated: true)
    }
    
    private func showImagePicker(didChooseImage: @escaping (String) -> Void) {
        imagePickerCoordinator.start(didChooseImage: didChooseImage)
    }
}
