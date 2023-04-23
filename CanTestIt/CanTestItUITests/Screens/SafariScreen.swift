//
//  SafariScreen.swift
//  CanTestItUITests
//
//  Created by Magdalena on 23/04/2023.
//

import XCTest

class SafariScreen: BaseScreen {
    let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
    private lazy var logoCantestit = safari.images["logo cantest it"].firstMatch
    
    func isCantestitLogoDisplayed() -> Bool{
        _ = SafariScreen().logoCantestit.waitForExistence(timeout: 5)
        return logoCantestit.exists
    }
}
