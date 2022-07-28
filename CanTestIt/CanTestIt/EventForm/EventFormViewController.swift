import UIKit

final class EventFormViewController: BaseViewController {
    private lazy var mainView = EventFormView()
    private let viewModel: EventFormViewModel
    
    init(viewModel: EventFormViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}
