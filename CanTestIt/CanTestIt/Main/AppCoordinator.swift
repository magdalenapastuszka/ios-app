import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
//        window.rootViewController = NavigationController(rootViewController: IntroBuilder().build())
        window.makeKeyAndVisible()
    }
}
