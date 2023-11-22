//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Данік on 25/08/2023.
//

import XCTest

final class MoviesUITests: XCTestCase {
    
    var app: XCUIApplication!

    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testNewsFeedInteractions() throws {
//         Tap on the first cell
        let firstCell = app.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "Failed to load the first cell in time.")
        
        // Define the start and end points for the swipe
        let start = app.windows.element(boundBy: 0).coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        let end = app.windows.element(boundBy: 0).coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))

        // Perform the swipe
        start.press(forDuration: 0.3, thenDragTo: end)
        
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "Failed to load the first cell in time.")

        firstCell.tap()
        

        // Go back
        let backButton = app.navigationBars.buttons["backArrowButton"]
        backButton.tap()

        // Tap on the second cell
        let secondCell = app.cells.element(boundBy: 1)
        secondCell.tap()
        
        // Swipe up
        app.swipeUp()
        app.swipeUp()

        // Go back
        backButton.tap()

        // Swipe up
        app.swipeUp()
        app.swipeUp()

        // Tap on the third cell
        let thirdCell = app.cells.element(boundBy: 2)
        thirdCell.tap()
        
        // Swipe up
        app.swipeUp()
//        
//        let actorCell = app.cells.matching(identifier: "actorCell1")
//        actorCell.element.tap()
        
        // Go back
        backButton.tap()

        let firstTab = app.tabBars.buttons.element(boundBy: 0)
        let secondTab = app.tabBars.buttons.element(boundBy: 1)
        let thirdTab = app.tabBars.buttons.element(boundBy: 2)
        let fourthTab = app.tabBars.buttons.element(boundBy: 3)

        secondTab.tap()
        thirdTab.tap()
        fourthTab.tap()

        firstTab.tap()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()
        app.swipeDown()

        // Perform the swipe
        start.press(forDuration: 0.3, thenDragTo: end)
    }
}
