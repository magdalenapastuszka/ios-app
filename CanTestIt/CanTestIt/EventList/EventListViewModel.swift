import Foundation
import Combine
import UIKit

final class EventListViewModel {
    @Published var tableViewData: [EventListData] = []
    @Published var isLoading: Bool = false
    
    private var filteredEvents: [Event] = [] {
        didSet {
            filteredEvents.isEmpty
            ? createEmptyTableViewData()
            : createTableViewData()
        }
    }
    private var events: [Event] = []
    private var cancellable: AnyCancellable?
    private let eventsFetcher: EventsAPIManagerFetcher
    private let showEventForm: (Event?, Bool) -> Void
    
    init(
        eventsFetcher: EventsAPIManagerFetcher,
        showEventForm: @escaping (Event?, Bool) -> Void) {
        self.eventsFetcher = eventsFetcher
        self.showEventForm = showEventForm
    }
    
    func loadModel() -> EventListView.Model {
        EventListView.Model(
            welcomeText: "event-list.welcome-text".localized,
            title: "event-list.title".localized,
            searchFieldPlaceholder: "event-list.search-field-placeholder".localized,
            eventsButtonTitle: "event-list.events-button-title".localized
        )
    }
    
    func loadEvents() {
        isLoading = true
        cancellable = eventsFetcher.getEvents()
            .sink { [weak self] response in
                self?.isLoading = false
                
                if case .failure = response {
                    self?.createEmptyTableViewData()
                }
            } receiveValue: { [weak self] events in
                self?.filteredEvents = events
                self?.events = events
            }
    }
    
    func didChangeSearchField(text: String?) {
        guard let text = text,
        !text.isEmpty else {
            filteredEvents = events
            return
        }
        
        filteredEvents = events.filter { $0.name.lowercased().contains(text.lowercased()) }
    }
    
    func didTapEvent(index: Int) {
        guard !filteredEvents.isEmpty else { return }
        
        showEventForm(filteredEvents[index], false)
    }
    
    func didTapAddButton() {
        showEventForm(nil, true)
    }
    
    private func createEmptyTableViewData() {
        tableViewData = [.init(
            key: .empty,
            values: [.empty(.init())]
        )]
    }
    
    private func createTableViewData() {
        tableViewData = [
            .init(
                key: .main,
                values:
                    filteredEvents.map {
                        .main(.init(
                            title: $0.name,
                            image: $0.image,
                            priceTitle: "event-form.price-field-title".localized,
                            price: $0.plnPrice,
                            category: $0.category,
                            startDateTitle: "event-form.start-date-field-title".localized,
                            startDate: DateFormatter.yyyyMMdd.string(from: $0.startDate ?? Date()),
                            startHour: $0.startHour
                        ))
                    }
            )]
    }
}
