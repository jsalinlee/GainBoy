//
//  LogEntryInfoDataSource.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 7/3/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class LogEntryInfoDataSource: NSObject, UITableViewDataSource {
    var sections = 4
    var exercises: [Exercise] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in 0..<sections {
            if section == i {
                return exercises[i].reps.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setTableViewCell", for: indexPath) as! SetTableViewCell
        cell.setNumber.text = String(indexPath.row)
        cell.repsTextField.placeholder = "0"
        cell.weightTextField.placeholder = "0"
        return cell
    }
}
