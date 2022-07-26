import Foundation

struct Event: Codable {
    let id = UUID()
    var title: String
    var category: String
}

extension Event: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
}
