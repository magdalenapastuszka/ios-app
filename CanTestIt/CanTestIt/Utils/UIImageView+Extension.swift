import UIKit
import Kingfisher

extension UIImageView {
    func handleImage(with name: String?) {
        let url = URL(string: AppVariables.baseURL + "images/" + (name ?? "empty"))
        DispatchQueue.main.async { [weak self] in
            self?.kf.indicatorType = .activity
            self?.kf.setImage(with: url) { result in
                switch result {
                case .failure(_):
                    self?.image = .emptyImage
                    self?.contentMode = .center
                case .success(let imageResult):
                    self?.image = imageResult.image
                    self?.contentMode = .scaleAspectFill
                }
            }
        }
    }
}
