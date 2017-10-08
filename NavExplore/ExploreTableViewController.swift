//
//  ExploreTableTableViewController.swift
//  NavExplore
//
//  Created by Denis Hennessy on 07/10/2017.
//  Copyright © 2017 Peer Assembly Ltd. All rights reserved.
//

import UIKit

@IBDesignable class ExploreTableViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating {

    @IBInspectable var enableSearch: Bool = false
    @IBInspectable var hideSearchOnScroll: Bool = true
    @IBInspectable var numberSections: Int = 5
    @IBInspectable var rowsPerSection: Int = 5
    
    var dataSource: SimpleDataSource!
    var searchSource: SimpleDataSource!
    var searchController: UISearchController!
    var resultsController: ResultsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = SimpleDataSource(sections: numberSections, rowsPerSection: rowsPerSection)
        if enableSearch {
            searchSource = SimpleDataSource(sections: numberSections, rowsPerSection: rowsPerSection)
            resultsController = storyboard!.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController
            resultsController?.dataSource = searchSource
            searchController = UISearchController(searchResultsController: resultsController)
            searchController.delegate = self
            searchController.searchResultsUpdater = self
            if #available(iOS 11.0, *) {
                navigationItem.searchController = searchController
                navigationItem.hidesSearchBarWhenScrolling = false
            } else {
                tableView.tableHeaderView = searchController.searchBar
            }
            definesPresentationContext = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = hideSearchOnScroll
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.displaySections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.displayRows[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource.displayRows[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if dataSource.sections.count == 1 {
            return nil
        } else {
            return dataSource.displaySections[section]
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        searchSource.searchString = searchController.searchBar.text!.trimmingCharacters(in: CharacterSet.whitespaces)
        resultsController.tableView.reloadData()
    }
}
