import Foundation

final class EventListViewModel {
    @Published var tableViewData: [EventListData] = [.init(key: .main, values: [.main(EventListTableViewCell.Model(title: "title title", image: .event, priceTitle: "Price", price: "200 USD", category: "Festival", startDateTitle: "Start date", startDate: "11-12-2022", startHour: "8:00")),
                                                                                .main(EventListTableViewCell.Model(title: "title title", image: .event, priceTitle: "Price", price: "200 USD", category: "Festival", startDateTitle: "Start date", startDate: "11-12-2022", startHour: "8:00")),
                                                                                .main(EventListTableViewCell.Model(title: "title title", image: .event, priceTitle: "Price", price: "200 USD", category: "Festival", startDateTitle: "Start date", startDate: "11-12-2022", startHour: "8:00")),
                                                                                .main(EventListTableViewCell.Model(title: "title title", image: .noResult, priceTitle: "Price", price: "200 USD", category: "Festival", startDateTitle: "Start date", startDate: "11-12-2022", startHour: "8:00"))])]
    
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
