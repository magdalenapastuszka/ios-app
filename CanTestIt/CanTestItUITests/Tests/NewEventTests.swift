//
//  NewEventTests.swift
//  CanTestItUITests
//
//  Created by Magdalena on 23/04/2023.
//

import XCTest

class NewEventTests: BaseTest{
    
    func testAddNewEvent(){
        let name = "Test\(String (Int.random(in: 1...100)))"
        
        CommonSteps()
            .loginUser()
        EventListScreen()
            .tapAddEventButton()
        AddEventScreen()
            .tapCoverPhotoButton()
            .choosePictureWith(index: 2)
            .tapChooseButton()
            .enterEventName(name: name)
            .chooseEventCategoryWith(label: "Party")
            .chooseStartDate()
            .chooseEndDate()
            .enterEventPrice(price: "100")
            .tapPremiumSwitch()
            .tapSaveButton()
        XCTAssertTrue(EventListScreen()
            .isEventDisplayedWithName(name: name))
    }
}
