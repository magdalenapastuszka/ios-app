import UIKit

enum CoordinatorPresentationStyle {
    case root
    case push
    case modal
}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
}

extension Coordinator {
    func addChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter {
            $0 !== coordinator
        }
    }
    
    func removeChildren<T: Coordinator>(type coordinatorType: T.Type) {
        childCoordinators.removeAll {
            $0 is T
        }
    }
}

extension UINavigationController {
    @discardableResult func go(
        to viewController: UIViewController,
        as style: CoordinatorPresentationStyle,
        animated: Bool = true
    ) -> UINavigationController? {
        switch style {
        case .root:
            setViewControllers([viewController], animated: false)
            return nil
        case .push:
            pushViewController(viewController, animated: animated)
            return nil
        case .modal:
            if let nav = viewController as? UINavigationController {
                present(nav, animated: animated)
                return nav
            } else {
                let nav = UINavigationController(rootViewController: viewController)
                present(nav, animated: animated)
                return nav
            }
        }
    }
}
