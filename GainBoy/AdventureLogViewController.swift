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
    var selectedLogIndex = Int()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tableView.dataSource = adventureLogDataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showLogEntry", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = segue.destination as! UINavigationController
        let logEntryInfoViewController = navController.topViewController as! LogEntryInfoViewController
        logEntryInfoViewController.delegate = self
        
        if segue.identifier == "showLogEntry" {
            
            let indexPath = sender as! IndexPath
            logEntryInfoViewController.indexPath = indexPath
            logEntryInfoViewController.navigationItem.rightBarButtonItem?.title = "Edit"
            logEntryInfoViewController.navigationItem.leftBarButtonItem?.title = "Back"
            logEntryInfoViewController.logEntry = adventureLogDataSource.adventures[indexPath.row]
            logEntryInfoViewController.title = adventureLogDataSource.dateFormatter.string(from: adventureLogDataSource.adventures[indexPath.row].date)
            logEntryInfoViewController.date = adventureLogDataSource.adventures[indexPath.row].date
            logEntryInfoViewController.exercises = adventureLogDataSource.adventures[indexPath.row].exercises
            
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
    
    func addAdventure(by controller: LogEntryInfoViewController, t title: String, d date: Date, time: Date, w weight: Double, e exercises: [Exercise], indexPath: IndexPath?) {
        if let indexPath = indexPath {
            let editedLog = adventureLogDataSource.adventures[indexPath.row]
            editedLog.title = title
            editedLog.date = date
            editedLog.time = time
            editedLog.weight = weight
            editedLog.exercises = exercises
        } else {
            let newAdventure = Adventure(title: title, date: date, time: time, weight: weight, exercises: exercises)
            adventureLogDataSource.adventures.append(newAdventure)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
