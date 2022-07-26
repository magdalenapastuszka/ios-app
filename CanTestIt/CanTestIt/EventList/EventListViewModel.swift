import Foundation

final class EventListViewModel {
    @Published var tableViewData: [EventListData] = [.init(key: .empty, values: [.empty(.init())])]
    
    func loadModel() -> EventListView.Model {
        EventListView.Model(
            welcomeText: "event-list.welcome-text".localized,
            title: "event-list.title".localized,
            searchFieldPlaceholder: "event-list.search-field-placeholder".localized,
            eventsButtonTitle: "event-list.events-button-title".localized
        )
    }
    
    func didTapEvent(index: Int) {
        
    }
}
