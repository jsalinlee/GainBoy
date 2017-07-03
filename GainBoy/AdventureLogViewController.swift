//
//  AdventureLogViewController.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class AdventureLogViewController: UITableViewController, LogEntryInfoViewControllerDelegate {
    let adventureLogDataSource = AdventureLogDataSource()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tableView.dataSource = adventureLogDataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let logEntryInfoViewController = navController.topViewController as! LogEntryInfoViewController
        logEntryInfoViewController.delegate = self
        if segue.identifier == "showLogEntry" {
            logEntryInfoViewController.navigationItem.rightBarButtonItem?.title = "Edit"
            logEntryInfoViewController.navigationItem.leftBarButtonItem?.title = "Back"
        } else if segue.identifier == "addLogEntry" {
            logEntryInfoViewController.navigationItem.rightBarButtonItem?.title = "Done"
            logEntryInfoViewController.navigationItem.leftBarButtonItem?.title = "Cancel"
            let currentDate = Date.init()
            logEntryInfoViewController.title = adventureLogDataSource.dateFormatter.string(from: currentDate)
            logEntryInfoViewController.date = currentDate
        }
    }
    
    func cancelButtonPressed(by controller: LogEntryInfoViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addAdventure(by controller: LogEntryInfoViewController, t title: String, d date: Date, time: String, w weight: Double, e exercises: [Exercise]) {
        
    }
}
