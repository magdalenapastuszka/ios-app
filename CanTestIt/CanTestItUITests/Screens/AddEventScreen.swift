//
//  AddEventScreen.swift
//  CanTestItUITests
//
//  Created by Magdalena on 23/04/2023.
//

import XCTest

class AddEventScreen: BaseScreen {
    private lazy var coverPhotoButton = app.buttons[ElementId.AddEvent.coverPhotoButton].firstMatch
    private lazy var chooseButton = app.buttons[ElementId.AddEvent.chooseButton].firstMatch
    private lazy var eventNameTextField = app.textFields[ElementId.AddEvent.eventNameTextField].firstMatch
    private lazy var chooseCategoryDropdown = app.otherElements[ElementId.AddEvent.eventCategoryDropdown].firstMatch
    private lazy var eventPriceTextField = app.textFields[ElementId.AddEvent.eventPriceTextField].firstMatch
    private lazy var premiumEventSwitch = app.switches[ElementId.AddEvent.premiumEventSwitch].firstMatch
    private lazy var saveEventButton = app.buttons[ElementId.AddEvent.saveButton].firstMatch
    private lazy var startDateTextField = app.textFields [ElementId.AddEvent.startDateTextField].firstMatch
    private lazy var endDateTextField = app.textFields [ElementId.AddEvent.endDateTextField].firstMatch
    private lazy var calendarDoneButton = app.buttons["Done"].firstMatch
    
    @discardableResult
    func tapCoverPhotoButton() -> Self {
        coverPhotoButton.tap()
        return self
    }
    
    @discardableResult
    func choosePictureWith(index: Int) -> Self {
        swipeLeft(repetation: index - 1)
        return self
    }
    
    @discardableResult
    func tapChooseButton() -> Self{
        chooseButton.tap()
        return self
    }
    
    @discardableResult
    func enterEventName(name: String) -> Self{
        eventNameTextField.tap()
        eventNameTextField.typeText(name)
        return self
    }
    
    @discardableResult
    func chooseEventCategoryWith(label: String) -> Self{
        chooseCategoryDropdown.tap()
        swipeDownTo(text: app.staticTexts[label].firstMatch)
        app.staticTexts[label].tap()
        return self
    }
    
    @discardableResult
    func chooseStartDate() -> Self {
        startDateTextField.tap()
        calendarDoneButton.tap()
        return self
    }
    
    @discardableResult
    func chooseEndDate() -> Self {
        endDateTextField.tap()
        calendarDoneButton.tap()
        return self
    }
    
    @discardableResult
    func enterEventPrice(price: String) -> Self {
        eventPriceTextField.tap()
        eventPriceTextField.typeText(price)
        return self
    }
    
    @discardableResult
    func tapPremiumSwitch() -> Self {
        premiumEventSwitch.tap()
        return self
    }
    
    @discardableResult
    func tapSaveButton() -> Self {
        saveEventButton.tap()
        return self
    }
}
