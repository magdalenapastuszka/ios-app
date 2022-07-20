import UIKit
import SwiftUI

final class IntroCoordinator: Coordinator {
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
        let vc =  UIHostingController(rootView: IntroView(
            viewModel: IntroViewModel(
                showLoginScreen: showLoginScreen,
                showFacebook: showFacebook,
                showInstagram: showInstagram,
                showLinkedIn: showLinkedIn
            )
        ))
        
        navigationController.go(to: vc, as: .root)
    }
    
    private func showLoginScreen() {
        
    }
    
    private func showFacebook() {
        
    }
    
    private func showInstagram() {
        
    }
    
    private func showLinkedIn() {
        
    }
}
