import Foundation
import UIKit
import Combine

final class ImagePickerViewController: BaseViewController {
    private let viewModel: ImagePickerViewModel
    private lazy var mainView = ImagePickerView(
        model: viewModel.loadModel(),
        handleDidTapChooseButton: viewModel.handleDidTapChooseButton
    )
    
    private var cancellable: AnyCancellable?
    
    init(viewModel: ImagePickerViewModel) {
        self.viewModel = viewModel
        super.init()
        bindAction()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func bindAction() {
        cancellable = viewModel.$data
            .sink { [weak self] data in
                self?.mainView.reloadCollectionView(with: data)
            }
    }
}
