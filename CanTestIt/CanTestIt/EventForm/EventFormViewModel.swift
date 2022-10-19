import Foundation
import UIMagicDropDown
import Combine
import UIKit
import NotificationCenter

typealias EventFormAPIManager = EventsAPIManagerCreator & EventsAPIDeletor & EventsAPIManagerUpdater

enum EventFormObligatoryField {
    case title
    case price
}

final class EventFormViewModel {
    @Published var error: String?
    @Published var obligatoryFieldsWithError: [EventFormObligatoryField] = []
    @Published var isLoading: Bool = false
    @Published var selectedImage: String?
    @Published var notificationMessage: NotificationParameters?
    
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
            isDeleteButtonHidden: isDeleteButtonHidden,
            event: event
        )
    }
    
    func didTapSaveButton(formData: EventFormData) {
        event.isNil ? createEvent(from: formData) : updateEvent(from: formData)
    }
    
    func didTapCancelButton() {
        dismissView()
    }
    
    func didTapDeleteButton() {
        guard let id = event?.id else { return }
        
        isLoading = true
        eventFormAPIManager.deleteEvent(with: id)
            .sink { [weak self] response in
                self?.isLoading = false
                switch response {
                case .finished:
                    self?.notificationMessage = NotificationParameters.checkmark(description: "notification.deleted-event.description".localized)
                    self?.dismissView()
                case .failure(_):
                    self?.notificationMessage = .error
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func didTapPictureButton() {
        showImagePicker() { [weak self] image in
            self?.selectedImage = image
        }
    }
    
    func clearError(from field: EventFormObligatoryField) {
        obligatoryFieldsWithError.removeAll(where: { $0 == field })
    }
    
    private func createEvent(from formData: EventFormData) {
        guard let name = formData.name,
              let price = formData.price?.floatValue,
              !name.isEmpty else {
            handleError(formData: formData)
            return
        }
        
        let categoryIndex = formData.category
        let dateFrom = formData.dateFrom
        let dateTo = formData.dateTo
        let image = selectedImage
        
        error = nil
        eventFormAPIManager.createEvent(event: Event(
            name: name,
            description: "",
            category: categoryIndex.isNotNil ? categories[categoryIndex!].code : nil,
            price: price,
            dateFrom: dateFrom.isNotNil ? DateFormatter.iso8601.string(from: dateFrom!) : nil,
            dateTo: dateTo.isNotNil ? DateFormatter.iso8601.string(from: dateTo!) : nil,
            image: image,
            isPremium: formData.isPremium,
            id: nil
        )).sink { [weak self] response in
            self?.isLoading = false
            switch response {
            case .failure(_):
                self?.notificationMessage = .error
            case .finished:
                self?.notificationMessage = NotificationParameters.checkmark(description: "notification.added-event.description".localized)
                self?.dismissView()
            }
        } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    private func updateEvent(from formData: EventFormData) {
        guard let name = formData.name,
              let price = formData.price?.floatValue,
              !name.isEmpty else {
            handleError(formData: formData)
            return
        }
        
        let categoryIndex = formData.category
        let dateFrom = formData.dateFrom
        let dateTo = formData.dateTo
        let image = selectedImage
        
        error = nil
        eventFormAPIManager.updateEvent(event: Event(
            name: name,
            description: "",
            category: categoryIndex.isNotNil ? categories[categoryIndex!].code : nil,
            price: price,
            dateFrom: dateFrom.isNotNil ? DateFormatter.iso8601.string(from: dateFrom!) : nil,
            dateTo: dateTo.isNotNil ? DateFormatter.iso8601.string(from: dateTo!) : nil,
            image: image,
            isPremium: formData.isPremium,
            id: event?.id
        )).sink { [weak self] response in
            self?.isLoading = false
            switch response {
            case .failure(_):
                self?.notificationMessage = .error
            case .finished:
                self?.notificationMessage = NotificationParameters.checkmark(description: "notification.updated-event.description".localized)
                self?.dismissView()
            }
        } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    private func handleError(formData: EventFormData) {
        if formData.name.isNilOrEmpty {
            obligatoryFieldsWithError.append(.title)
        }
        if formData.price?.floatValue == nil {
            obligatoryFieldsWithError.append(.price)
        }
        error = "event-form.error".localized
    }
}
