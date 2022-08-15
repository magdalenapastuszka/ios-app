import UIKit
import SwiftUI
import Combine

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let window: UIWindow
    private let appEngine: AppEngine
    private var cancellables = Set<AnyCancellable>()
    
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
        downloadCategories()
        downloadEventImages()
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
    
    private func downloadCategories() {
         appEngine.categoriesCache.fetchCategories()
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    private func downloadEventImages() {
        appEngine.eventImagesCache.getImages()
            .sink { _ in }
            .store(in: &cancellables)
    }
}
