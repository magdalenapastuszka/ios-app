import UIKit

extension UIViewController {
    private var isModal: Bool {
        if let navigationController = navigationController {
            if navigationController.viewControllers.first != self {
                return false
            }
        }
        
        if presentingViewController != nil {
            return false
        }
        
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        
        if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    func configureHamburgerNav(target: Any?, action: Selector?) {
        let hamburgerButton = UIBarButtonItem(
            image: .hamburger,
            style: .plain,
            target: target,
            action: action
        )
        navigationItem.leftBarButtonItem = hamburgerButton
    }
    
    func configureGoBackNav() {
        let backButton = UIBarButtonItem(
            image: .arrowLeft,
            style: .plain,
            target: self,
            action: #selector(dismissOrPopup)
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func dismissOrPopup() {
        if isModal {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
