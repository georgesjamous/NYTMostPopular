//
//  TestUtils.swift
//  TestApp
//
//  Created by Georges Jamous on 3/3/19.
//  Copyright © 2020 Georges Jamous. All rights reserved.
//

import Foundation
import UIKit

final class TestUtils {
    
    static func FlagTableInClass(table: UITableView, className: String) {
        table.accessibilityIdentifier = TableIdentifierForClass(className: className)
    }
    
    static func FlagCellInTable(table: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        let tableViewId = "\(table.accessibilityIdentifier ?? "TableView")"
        let cellId = "\(CellIdentifierForId(cellId: cell.reuseIdentifier ?? ArticleTableViewCell.identifier)).\(indexPath.row)";
        cell.accessibilityIdentifier = "\(tableViewId).\(cellId)"
    }
    
    static func TableIdentifierForClass(className: String) -> String {
        return "\(className).TableView"
    }
    
    static func CellIdentifierForId(cellId: String) -> String {
        return "\(cellId)"
    }
}
