import Foundation
import UIKit
import Combine

final class ImagePickerViewController: BaseViewController {
    private let viewModel: ImagePickerViewModel
    private lazy var mainView = ImagePickerView(
        model: viewModel.loadModel(),
        handleDidTapChooseButton: viewModel.handleDidTapChooseButton
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ImagePickerViewModel) {
        self.viewModel = viewModel
        super.init()
        bindAction()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadImages()
    }
    
    private func bindAction() {
        viewModel.$data
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.mainView.reloadCollectionView(with: data)
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] newValue in
                newValue ? self?.showHud() : self?.dismissHud()
            }
            .store(in: &cancellables)
    }
}
