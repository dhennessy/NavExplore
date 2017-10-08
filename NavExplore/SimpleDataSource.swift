//
//  DummyDataSource.swift
//  NavExplore
//
//  Created by Denis Hennessy on 07/10/2017.
//  Copyright © 2017 Peer Assembly Ltd. All rights reserved.
//

import UIKit

class SimpleDataSource {
    
    var rows: [[String]] = []
    var sections: [String] = []
    var displayRows: [[String]] = []
    var displaySections: [String] = []
    var searchString: String? {
        didSet {
            updateSearchResults()
        }
    }
    
    init(sections: Int, rowsPerSection: Int) {
        for section in 0..<sections {
            let sectionName = "S\(section)"
            self.sections.append(sectionName)
            var rows: [String] = []
            for row in 0..<rowsPerSection {
                rows.append("\(sectionName)-R\(row)")
            }
            self.rows.append(rows)
        }
        updateSearchResults()
    }
    
    func updateSearchResults() {
        displaySections = []
        displayRows = []
        if searchString == nil || searchString! == "" {
            for section in 0..<sections.count {
                let sectionName = sections[section]
                var matchRows: [String] = []
                for row in 0..<rows[section].count {
                    matchRows.append(rows[section][row])
                }
                displaySections.append(sectionName)
                displayRows.append(matchRows)
            }
        } else {
            var matchRows: [String] = []
            for section in 0..<sections.count {
                for row in 0..<rows[section].count {
                    let value = rows[section][row]
                    if searchString == nil || searchString! == "" || value.contains(searchString!) {
                        matchRows.append(value)
                    }
                }
            }
            displaySections = [ "Search Results" ]
            displayRows = [matchRows]
        }
    }
}

