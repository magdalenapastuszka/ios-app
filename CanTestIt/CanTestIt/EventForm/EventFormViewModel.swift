import Foundation
import UIMagicDropDown
import Combine
import UIKit

typealias EventFormAPIManager = EventsAPIManagerCreator & EventsAPIDeletor

final class EventFormViewModel {
    @Published var error: String?
    @Published var isLoading: Bool = false
    @Published var selectedImage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private var event: Event?
    private let categories: [Category]
    private let eventFormAPIManager: EventFormAPIManager
    private let isDeleteButtonHidden: Bool
    private let showImagePicker: (@escaping (String) -> Void) -> Void
    private let dismissView: () -> Void
    
    init(
        event: Event?,
        categories: [Category],
        eventFormAPIManager: EventFormAPIManager,
        isDeleteButtonHidden: Bool,
        showImagePicker: @escaping (@escaping (String) -> Void) -> Void,
        dismissView: @escaping () -> Void
    ) {
        self.event = event
        self.categories = categories
        self.eventFormAPIManager = eventFormAPIManager
        self.isDeleteButtonHidden = isDeleteButtonHidden
        self.dismissView = dismissView
        self.showImagePicker = showImagePicker
        
        if let eventImage = event?.image {
            self.selectedImage = eventImage
        }
    }
    
    func loadModel() -> EventFormView.Model {
        EventFormView.Model(
            emptyPicture: .emptyImage,
            emptyPictureTitle: "event-form.empty-picture-title".localized,
            viewTitle: "event-form.title".localized,
            eventFieldTitle: "event-form.event-title-field".localized,
            eventFieldPlaceholder: "event-form.event-title-field-placeholder".localized,
            eventFieldIcon: .eventName,
            categoryFieldTitle: "event-form.category-field-title" .localized,
            categoryFieldPlaceholder: "event-form.category-field-placeholder".localized,
            categoryFieldData: categories.map({ UIMagicDropdownData(label: $0.name, value: $0.code) }),
            categoryFieldIcon: .eventCategory,
            startDateFieldTitle: "event-form.start-date-field-title".localized,
            startDateFieldPlaceholder: "event-form.start-date-field-placeholder".localized,
            startDateIcon: .eventCalendar,
            endDateFieldTitle: "event-form.end-date-field-title".localized,
            endDateFieldPlaceholder: "event-form.end-date-field-placeholder".localized,
            endDateIcon: .eventCalendar,
            priceFieldTitle: "event-form.price-field-title".localized,
            priceFieldPlaceholder: "event-form.price-field-placeholder".localized,
            priceFieldIcon: .eventPrice,
            premiumSwitchTitle: "event-form.premium-event-switch-title".localized,
            saveButtonTitle: "event-form.save-button-title".localized,
            cancelButtonTitle: "event-form.save-cancel-title".localized,
            deleteButtonTitle: "event-form.save-delete-title".localized,
            isDeleteButtonHidden: isDeleteButtonHidden
        )
    }
    
    func didTapSaveButton(formData: EventFormData) {
        guard let name = formData.name,
              let categoryIndex = formData.category,
              let price = formData.price?.floatValue,
              let dateFrom = formData.dateFrom,
              let dateTo = formData.dateTo,
              let image = selectedImage,
              !name.isEmpty,
              !image.isEmpty else {
            error = "event-form.error".localized
            return
        }
        
        error = nil
        eventFormAPIManager.createEvent(event: Event(
            name: name,
            description: "",
            category: categories[categoryIndex].code,
            price: price,
            dateFrom: dateFrom.ISO8601Format(),
            dateTo: dateTo.ISO8601Format(),
            image: image,
            isPremium: formData.isPremium,
            id: event?.id
        )).sink { [weak self] response in
            self?.isLoading = false
            switch response {
            case .failure(_):
                self?.error = "event-form.error".localized
            case .finished:
                self?.dismissView()
            }
        } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func didTapCancelButton() {
        dismissView()
    }
    
    func didTapDeleteButton() {
        guard let id = event?.id else { return }
        
        isLoading = true
        eventFormAPIManager.deleteEvent(with: id)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] result in
                guard result else { return }
                
                self?.dismissView()
            }.store(in: &cancellables)
    }
    
    func didTapPictureButton() {
        showImagePicker() { [weak self] image in
            self?.selectedImage = image
        }
    }
}
