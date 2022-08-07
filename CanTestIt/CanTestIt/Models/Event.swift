import Foundation
import UIKit

final class Event {
    var image: UIImage?
    var title: String?
    var category: String?
    var price: String?
    var startDate: String?
    var endDate: String?
    var isPremium: Bool?
    
    init(image: UIImage?, title: String?, category: String?, price: String?, startDate: String?, endDate: String?, isPremium: Bool?) {
        self.image = image
        self.title = title
        self.category = category
        self.price = price
        self.startDate = startDate
        self.endDate = endDate
        self.isPremium = isPremium
    }
}
