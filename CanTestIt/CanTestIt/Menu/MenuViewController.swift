import UIKit
import Combine

final class MenuViewController: BaseViewController {
    private lazy var mainView = MenuView(model: viewModel.loadModel())
    private let viewModel: MenuViewModel
    
    private var cancellable: AnyCancellable?
    
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init()
        bindAction()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func bindAction() {
        cancellable = viewModel.$menuRows
            .sink { [weak self] data in
                self?.mainView.reloadTable(with: data)
            }        
    }
}
