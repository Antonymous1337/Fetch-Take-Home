//
//  Fetch_Take_HomeUITests.swift
//  Fetch Take HomeUITests
//
//  Created by Antony Holshouser on 5/6/25.
//

import XCTest
@testable import Fetch_Take_Home

final class Fetch_Take_HomeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let customViewController = ViewControllerViewModel(APIEndpointType: .empty)
        XCTAssert(customViewController.recipeContainer != nil)
        XCTAssert(customViewController.recipeContainer!.recipes.isEmpty)
        XCTAssert(customViewController.recipeContainer!.processed)
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
