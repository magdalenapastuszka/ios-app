import UIKit

final class EventListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private lazy var menuCoordinator = MenuCoordiantor(
        navigationController: navigationController,
        appEngine: appEngine
    )
    
    private lazy var evenFormCoordinator = EventFormCoordinator(
        navigationController: navigationController,
        appEngine: appEngine
    )
    private let appEngine: AppEngine
    
    init(
        navigationController: UINavigationController,
        appEngine: AppEngine
    ) {
        self.navigationController = navigationController
        self.appEngine = appEngine
    }
    
    func start() {
        let vc = EventListViewController(viewModel: EventListViewModel(
            eventsFetcher: EventsAPIManager(apiClient: appEngine.apiClient),
            showEventForm: showEventForm
        ))
        vc.configureHamburgerNav(target: self, action: #selector(showMenu))
        navigationController.go(to: vc, as: .root)
    }
    
    @objc private func showMenu() {
        menuCoordinator.start()
    }
    
    private func showEventForm(event: Event?, isDeleteButtonHidden: Bool) {
        evenFormCoordinator.start(isDeleteButtonHidden: isDeleteButtonHidden)
    }
}
