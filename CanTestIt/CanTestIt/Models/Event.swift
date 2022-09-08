import Foundation
import UIKit

final class Event: Codable {
    var name: String
    var description: String
    var category: String
    var price: Float
    var dateFrom: String
    var dateTo: String
    var image: String
    var isPremium: Bool?
    var id: String?
    
    var startDate: Date? {
        DateFormatter.iso8601.date(from: dateFrom)
    }
    
    var startHour: String? {
        guard let startDate = startDate else {
            return nil
        }

        return DateFormatter.HHmma.string(from: startDate)
    }
    
    var endDate: Date? {
        DateFormatter.iso8601.date(from: dateTo)
    }
    
    var endHour: String? {
        guard let endDate = endDate else {
            return nil
        }

        return DateFormatter.HHmma.string(from: endDate)
    }
    
    var plnPrice: String {
        "\(price) \("pln-currency".localized)"
    }
    
    init(
        name: String,
        description: String,
        category: String,
        price: Float,
        dateFrom: String,
        dateTo: String,
        image: String,
        isPremium: Bool,
        id: String? = nil
    ) {
        self.name = name
        self.description = description
        self.category = category
        self.price = price
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.image = image
        self.isPremium = isPremium
        self.id = id
    }
}
