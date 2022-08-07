import Foundation
import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let window: UIWindow
    private let appEngine: AppEngine
    
    private lazy var introCoordinator = IntroCoordinator(
        navigationController: navigationController,
        appEngine: appEngine
    )
    private lazy var loginCoordinator = LoginCoordinator(
        navigationController: navigationController,
        appEngine: appEngine
    )
    
    init(
        window: UIWindow,
        navigationController: UINavigationController,
        appEngine: AppEngine
    ) {
        self.window = window
        self.navigationController = navigationController
        self.appEngine = appEngine
        configureStyle()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        appEngine.userDefaultsManager.wasIntroDisplayed
        ? loginCoordinator.start()
        : introCoordinator.start()
    }
    
    private func configureStyle() {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.backgroundColor = .backgroundColor
        navigationController.navigationBar.barTintColor = .backgroundColor
    }
}
