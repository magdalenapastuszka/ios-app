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
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        appEngine.userDefaultsManager.wasIntroDisplayed
        ? loginCoordinator.start()
        : introCoordinator.start()
    }
}
