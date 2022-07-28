import Foundation
import UIKit

final class ImagePickerViewController: BaseViewController {
    private let viewModel: ImagePickerViewModel
    private lazy var mainView = ImagePickerView(model: viewModel.loadModel())
    
    init(viewModel: ImagePickerViewModel) {
        self.viewModel = viewModel
        super.init()
        bindAction()
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func bindAction() {
        viewModel.$data
            .sink { [weak self] data in
                mainView.reloadCollectionView(with: data)
            }
    }
}
