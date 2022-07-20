import Foundation
import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let window: UIWindow
    private let appEngine: AppEngine
    
    init(
        window: UIWindow,
        navigationController: UINavigationController,
        appEngine: AppEngine
    ) {
        self.window = window
        self.navigationController = navigationController
        self.appEngine = appEngine
    }
    
    func start() {
        navigationController = UINavigationController(
            rootViewController: UIHostingController(
                rootView: IntroView(
                    viewModel: IntroViewModel(
                        showLoginScreen: showLoginScreen
                    )
                )
            )
        )
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func showLoginScreen() {
        
    }
}
