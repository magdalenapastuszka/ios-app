import Foundation
import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let window: UIWindow
    
    init(
        window: UIWindow,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController = UINavigationController(
            rootViewController: UIHostingController(
                rootView: IntroView(viewModel: IntroViewModel()
                                   )
            )
        )
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
