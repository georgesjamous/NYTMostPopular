//
//  TestAppUITests.swift
//  TestAppUITests
//
//  Created by Georges Jamous on X/X/X.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import XCTest

class TestAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testThatTableViewPopulatesAndIsSelectable(){
        let myTable = app.tables.matching(identifier: "ArticlesController.TableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "ArticlesController.TableView.ArticleTableViewCell.0")
        let _ = waitForElementToAppear(cell)
        cell.tap()
    }
    
    func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let expectation = XCTKVOExpectation(keyPath: "exists", object: element, expectedValue: true)
        let result = XCTWaiter().wait(for: [expectation], timeout: 10)
        return result == .completed
    }
}
