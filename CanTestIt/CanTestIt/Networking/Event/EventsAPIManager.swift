import Foundation
import Combine

protocol EventsAPIManagerFetcher {
    func getEvents() -> AnyPublisher<[Event], NetworkRequestError>
}

protocol EventsAPIManagerCreator {
    func createEvent(event: Event) -> AnyPublisher<Bool, NetworkRequestError>
}

protocol EventsAPIDeletor {
    func deleteEvent(with id: String) -> AnyPublisher<Bool, NetworkRequestError>
}

protocol EventsAPIManager: EventsAPIManagerFetcher, EventsAPIManagerCreator, EventsAPIDeletor {}

final class EventsAPIManagerImpl: EventsAPIManager {
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
    
    func deleteEvent(with id: String) -> AnyPublisher<Bool, NetworkRequestError> {
        apiClient.dispatch(DeleteEventRequest(id: id))
    }
}
