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
        let vc = MenuViewController(viewModel: MenuViewModel())
        vc.configureGoBackNav()
        navigationController.go(to: vc, as: .push)
    }
    
    private func logOut() {
        loginCoordinator.start()
    }
}
