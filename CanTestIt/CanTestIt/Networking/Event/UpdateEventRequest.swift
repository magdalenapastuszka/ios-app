import Foundation

struct UpdateEventRequest: HTTPRequest {
    typealias ReturnType = NoReply
    
    var path: String { "events/\(event.id ?? "")" }
    let queryParams: HTTPQueryParams? = nil
    let method: HTTPMethod = .put
    var body: HTTPParams? {
        event.asDictionary
    }
    
    private let event: Event
    
    init(event: Event) {
        self.event = event
    }
}
