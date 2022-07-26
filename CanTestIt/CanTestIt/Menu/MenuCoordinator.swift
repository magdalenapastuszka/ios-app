import UIKit

final class MenuCoordiantor: Coordinator {
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
        let vc = MenuViewController(viewModel: MenuViewModel())
        vc.configureGoBackNav()
        navigationController.go(to: vc, as: .push)
    }
}
