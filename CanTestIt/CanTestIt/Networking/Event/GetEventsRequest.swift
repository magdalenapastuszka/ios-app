import Foundation

struct GetEventsRequest: HTTPRequest {
    typealias ReturnType = [Event]
    
    let path: String = "events"
    var queryParams: HTTPQueryParams? = nil
    var method: HTTPMethod = .get
}
