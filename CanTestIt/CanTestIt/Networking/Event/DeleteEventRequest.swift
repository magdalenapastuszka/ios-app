import Foundation

struct DeleteEventRequest: HTTPRequest {
    typealias ReturnType = NoReply
    
    var path: String { "events/\(id)" }
    let queryParams: HTTPQueryParams? = nil
    let method: HTTPMethod = .delete
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
}
