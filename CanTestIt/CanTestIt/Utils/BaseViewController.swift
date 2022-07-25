
import UIKit

open class BaseViewController: UIViewController {

    public init() {
        super.init(nibName: nil, bundle: nil)
        Logger.other("[Init: ViewController \(self)]")
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        Logger.other("[Dealloc: ViewController \(self)]")
    }
}
