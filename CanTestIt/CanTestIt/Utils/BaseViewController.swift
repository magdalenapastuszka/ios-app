import JGProgressHUD
import UIKit

open class BaseViewController: UIViewController {

    private lazy var progressHud = JGProgressHUD()
    init() {
        super.init(nibName: nil, bundle: nil)
        Logger.other("[Init: ViewController \(self)]")
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        Logger.other("[Dealloc: ViewController \(self)]")
    }
    
    func showHud() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.progressHud.show(in: self.view, animated: true)
        }
    }
    
    func dismissHud() {
        progressHud.dismiss(animated: true)
    }
}
