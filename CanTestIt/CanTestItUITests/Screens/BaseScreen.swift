//
//  BaseScreen.swift
//  CanTestItUITests
//
//  Created by Magdalena on 22/04/2023.
//

import XCTest

class BaseScreen {
    let app = XCUIApplication()
    
    func swipeLeft(repetation: Int) {
        var numberOfSwipes = 0
        
        while numberOfSwipes < repetation {
            app.collectionViews.element.swipeLeft()
            numberOfSwipes += 1
        }
    }
    
    func swipeDownTo(text element: XCUIElement) {
        var numberOfSwipes = 0
        
        while !element.isHittable && numberOfSwipes < 10 {
            app.tables.element.swipeUp()
            numberOfSwipes += 1
        }
    }
}
