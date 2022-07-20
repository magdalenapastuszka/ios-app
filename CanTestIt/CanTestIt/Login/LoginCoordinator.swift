import UIKit
import SwiftUI

final class LoginCoordinator: Coordinator {
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
        let vc = UIHostingController(rootView: LoginView(
            viewModel: LoginViewModel()
        ))
        
        navigationController.go(to: vc, as: .root)
    }
}
