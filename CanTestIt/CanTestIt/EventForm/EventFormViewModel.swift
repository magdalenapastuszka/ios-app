import Foundation

final class EventFormViewModel {
    @Published var error: String? = "dasfsafsdf"
    
    private var event: Event?
    private let showImagePicker: () -> Void
    private let dismissView: () -> Void

    init(
        event: Event?,
        showImagePicker: @escaping () -> Void,
        dismissView: @escaping () -> Void
    ) {
        self.event = event
        self.dismissView = dismissView
        self.showImagePicker = showImagePicker
    }
    
    func loadModel() -> EventFormView.Model {
        EventFormView.Model(
            viewTitle: "event-form.title".localized,
            eventFieldTitle: "event-form.event-title-field".localized,
            eventFieldPlaceholder: "event-form.event-title-field-placeholder".localized,
            categoryFieldTitle: "event-form.category-field-title" .localized,
            categoryFieldPlaceholder: "event-form.category-field-placeholder".localized,
            startDateFieldTitle: "event-form.start-date-field-title".localized,
            startDateFieldPlaceholder: "event-form.start-date-field-placeholder".localized,
            endDateFieldTitle: "event-form.end-date-field-title".localized,
            endDateFieldPlaceholder: "event-form.end-date-field-placeholder".localized,
            priceFieldTitle: "event-form.price-field-title".localized,
            priceFieldPlaceholder: "event-form.price-field-placeholder".localized,
            premiumSwitchTitle: "event-form.premium-event-switch-title".localized,
            saveButtonTitle: "event-form.save-button-title".localized,
            cancelButtonTitle: "event-form.save-cancel-title".localized,
            deleteButtonTitle: "event-form.save-delete-title".localized,
            isDeleteButtonHidden: false
        )
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
}
