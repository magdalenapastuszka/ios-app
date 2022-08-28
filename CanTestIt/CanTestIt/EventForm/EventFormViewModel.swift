import Foundation
import UIMagicDropDown
import Combine
import UIKit

final class EventFormViewModel {
    @Published var error: String?
    @Published var isLoading: Bool = false
    @Published var categoriesDropdownData: [UIMagicDropdownData] = []
    @Published var selectedImage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private var event: Event?
    private let categoriesCache: CategoriesCache
    private let eventsCreator: EventsAPIManagerCreator
    private let isDeleteButtonHidden: Bool
    private let showImagePicker: (@escaping (String) -> Void) -> Void
    private let dismissView: () -> Void
    
    init(
        event: Event?,
        categoriesCache: CategoriesCache,
        eventsCreator: EventsAPIManagerCreator,
        isDeleteButtonHidden: Bool,
        showImagePicker: @escaping (@escaping (String) -> Void) -> Void,
        dismissView: @escaping () -> Void
    ) {
        self.event = event
        self.categoriesCache = categoriesCache
        self.eventsCreator = eventsCreator
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
    
    func loadCategoriesDropdownData(){
        categoriesCache.fetchCategories()
            .sink { [weak self] categories in
                self?.categoriesDropdownData = categories.map { UIMagicDropdownData(label: $0.name, value: $0.code) }
            }
            .store(in: &cancellables)
    }
    
    func didTapSaveButton(formData: EventFormData) {
        guard let name = formData.name,
              let categoryIndex = formData.category,
              let price = formData.price?.floatValue,
              let dateFrom = formData.dateFrom,
              let dateTo = formData.dateTo,
              let image = selectedImage,
              !name.isEmpty,
              !dateFrom.isEmpty,
              !dateTo.isEmpty,
              !image.isEmpty else {
            error = "event-form.error".localized
            return
        }
        
        error = nil
        eventsCreator.createEvent(event: Event(
            name: name,
            description: "",
            category: categoriesDropdownData[categoryIndex].label,
            price: price,
            dateFrom: dateFrom,
            dateTo: dateTo,
            image: image,
            isPremium: formData.isPremium,
            id: event?.id
        )).sink { [weak self] _ in
            self?.isLoading = false
        } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    func didTapCancelButton() {
        dismissView()
    }
    
    func didTapDeleteButton() {
        
    }
    
    func didTapPictureButton() {
        showImagePicker() { [weak self] image in
            self?.selectedImage = image
        }
    }
    
    private func validate(formData: EventFormData) {

    }
}
