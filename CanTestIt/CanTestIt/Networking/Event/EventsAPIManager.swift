import Foundation
import Combine

protocol EventsAPIManagerFetcher {
    func getEvents() -> AnyPublisher<[Event], NetworkRequestError>
}

protocol EventsAPIManagerCreator {
    func createEvent(event: Event) -> AnyPublisher<Bool, NetworkRequestError>
}

final class EventsAPIManager: EventsAPIManagerFetcher, EventsAPIManagerCreator {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getEvents() -> AnyPublisher<[Event], NetworkRequestError> {
        apiClient.dispatch(GetEventsRequest())
    }
    
    func createEvent(event: Event) -> AnyPublisher<Bool, NetworkRequestError> {
        apiClient.dispatch(CreateEventRequest(event: event))
    }
}
