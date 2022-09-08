import Foundation

struct CreateEventRequest: HTTPRequest {
    typealias ReturnType = NoReply
    
    let path: String = "events"
    let queryParams: HTTPQueryParams? = nil
    let method: HTTPMethod = .post
    var body: HTTPParams? {
        event.asDictionary
    }
    
    private let event: Event
    
    init(event: Event) {
        self.event = event
    }
}
