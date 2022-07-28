import UIKit

final class MenuCoordiantor: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private lazy var loginCoordinator = LoginCoordinator(
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
    
    func start() {
        let vc = MenuViewController(viewModel: MenuViewModel(
            logOut: logOut
        ))
        vc.configureGoBackNav()
        navigationController.go(to: vc, as: .push)
    }
    
    private func logOut() {
        ImagePickerCoordiantor(navigationController: navigationController, appEngine: appEngine).start()
//        loginCoordinator.start()
    }
}
