//
//  EventListScreen.swift
//  CanTestItUITests
//
//  Created by Magdalena on 22/04/2023.
//

import XCTest

class EventListScreen: BaseScreen {
    private lazy var eventListHeader = app.staticTexts[ElementId.EventList.eventListHeader].firstMatch
    private lazy var addEventButton = app.buttons[ElementId.EventList.addEventButton].firstMatch
    
    func tapAddEventButton(){
        addEventButton.tap()
    }
    
    func isEventListHeaderDisplayed() -> Bool{
        _ = eventListHeader.waitForExistence(timeout: 5)
        return eventListHeader.exists
    }
    
    func isEventDisplayedWithName(name: String) -> Bool {
        let eventName = app.staticTexts[name].firstMatch
        
        swipeDownTo(text: eventName)
        return eventName.exists
    }
}
