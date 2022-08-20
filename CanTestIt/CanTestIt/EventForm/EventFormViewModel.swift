import Foundation
import UIMagicDropDown
import Combine

final class EventFormViewModel {
    @Published var error: String?
    @Published var isLoading: Bool = false
    @Published var categoriesDropdownData: [UIMagicDropdownData] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var event: Event?
    private let categoriesCache: CategoriesCache
    private let showImagePicker: () -> Void
    private let dismissView: () -> Void

    init(
        event: Event?,
        categoriesCache: CategoriesCache,
        showImagePicker: @escaping () -> Void,
        dismissView: @escaping () -> Void
    ) {
        self.event = event
        self.categoriesCache = categoriesCache
        self.dismissView = dismissView
        self.showImagePicker = showImagePicker
    }
    
    func loadModel() -> EventFormView.Model {
        EventFormView.Model(
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
            isDeleteButtonHidden: false
        )
    }
    
    func loadCategoriesDropdownData(){
        categoriesCache.fetchCategories()
            .sink { [weak self] categories in
                self?.categoriesDropdownData = categories.map { UIMagicDropdownData(label: $0.name, value: $0.code) }
            }
            .store(in: &cancellables)
    }
    
    func didTapSaveButton() {
        
    }
    
    func didTapCancelButton() {
        dismissView()
    }
    
    func didTapDeleteButton() {
        
    }
    
    func didTapImageView() {
        showImagePicker()
    }
    
    
    func didTapEndDateTextField() {

    }
    
    func didTapStartDateTextField() {

    }
}
