import UIKit
import Combine

final class EventFormViewController: BaseViewController {
    private lazy var mainView = EventFormView(
        model: viewModel.loadModel(),
        handleDidTapSaveButton: viewModel.didTapSaveButton,
        handleDidTapCancelButton: viewModel.didTapCancelButton,
        handleDidTapDeleteButton: viewModel.didTapDeleteButton,
        handleDidTapPictureButton: viewModel.didTapPictureButton
    )

    private let viewModel: EventFormViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: EventFormViewModel) {
        self.viewModel = viewModel
        super.init()
        bindAction()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCategoriesDropdownData()
    }
    
    private func bindAction() {
        viewModel.$error
            .sink { [weak self] error in
                self?.mainView.showError(message: error)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                isLoading ? self?.showHud() : self?.dismissHud()
            }
            .store(in: &cancellables)
        
        viewModel.$categoriesDropdownData
            .sink { [weak self] dropdownData in
                self?.mainView.fill(dropDownData: dropdownData)
            }
            .store(in: &cancellables)
    }
}
