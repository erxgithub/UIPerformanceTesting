//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Eric Gregor on 2018-02-23.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        deleteAllMeals()
    }
    
    func addMeal(mealName: String, numberOfCalories: Int) {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.typeText(String(numberOfCalories))
        addAMealAlert.buttons["Ok"].tap()
    }
    
    func deleteMeal(mealName: String, numberOfCalories: Int) {
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }
    
    func deleteAllMeals()
    {
        let table = app.tables.element(boundBy: 0)
        
        while table.cells.count > 0
        {
            let tableCell = table.cells.element(boundBy: 0)
            tableCell.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }

    func mealDetail(mealName: String, numberOfCalories: Int) {
        app.tables.staticTexts["\(mealName) - \(numberOfCalories)"].tap()
    }
    
    func testAddMeal() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        addMeal(mealName: "Burger", numberOfCalories: 300)
        XCTAssertTrue(app.tables/*@START_MENU_TOKEN@*/.staticTexts["Burger - 300"]/*[[".cells.staticTexts[\"Burger - 300\"]",".staticTexts[\"Burger - 300\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }
    
    func testDeleteMeal() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        deleteMeal(mealName: "Burger", numberOfCalories: 300)
        XCTAssertFalse(app.tables/*@START_MENU_TOKEN@*/.staticTexts["Burger - 300"]/*[[".cells.staticTexts[\"Burger - 300\"]",".staticTexts[\"Burger - 300\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }

    func testDeleteAllMeals()
    {
        deleteAllMeals()
        
        let table = app.tables.element(boundBy: 0)
        XCTAssertEqual(table.cells.count, 0)
    }

    func testShowMealDetail() {
        mealDetail(mealName: "Burger", numberOfCalories: 300)
        XCTAssertEqual(app.staticTexts["detailViewControllerLabel"].label, "Burger - 300")

        app.navigationBars["Detail"].buttons["Master"].tap()
    }

}
