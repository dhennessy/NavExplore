//
//  ResultsViewController.swift
//  NavExplore
//
//  Created by Denis Hennessy on 07/10/2017.
//  Copyright © 2017 Peer Assembly Ltd. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    var dataSource = SimpleDataSource(sections: 5, rowsPerSection: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
