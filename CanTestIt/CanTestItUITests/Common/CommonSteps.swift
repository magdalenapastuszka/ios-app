//
//  CommonSteps.swift
//  CanTestItUITests
//
//  Created by Magdalena on 23/04/2023.
//

import XCTest

class CommonSteps: BaseScreen {
    
    func loginUser(username: String = "user", password: String = "password") {
        LoginScreen()
            .enterUsername(username: username)
            .enterPassword(password: password)
            .tapLoginButton()
    }
}
