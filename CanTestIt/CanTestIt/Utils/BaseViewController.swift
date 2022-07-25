
import UIKit

open class BaseViewController: UIViewController {

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
}
