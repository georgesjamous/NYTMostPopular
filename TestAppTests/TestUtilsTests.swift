//
//  TestUtilsTests.swift
//  TestAppTests
//
//  Created by Georges Jamous on 3/3/19.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import XCTest
@testable import TestApp

class TestUtilsTests: XCTestCase {
    func test(){
        let table = UITableView.init()
        TestUtils.FlagTableInClass(table: table, className: "Cars")
        XCTAssertEqual(table.accessibilityIdentifier, "Cars.TableView")

       let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "CellA")
        TestUtils.FlagCellInTable(table: table, cell: cell, indexPath: IndexPath.init(row: 0, section: 0))
        XCTAssertEqual(cell.accessibilityIdentifier, "Cars.TableView.CellA.0")
    }
    
    func testIdentifiers(){
        XCTAssertEqual(TestUtils.TableIdentifierForClass(className: "ClassA"), "ClassA.TableView")
        XCTAssertEqual(TestUtils.CellIdentifierForId(cellId: "Cell"), "Cell")
    }
}
