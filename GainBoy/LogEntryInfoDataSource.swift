//
//  LogEntryInfoDataSource.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 7/3/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class LogEntryInfoDataSource: NSObject, UITableViewDataSource, UITextFieldDelegate {
    var exercises: [Exercise] = []
    var currentlyEditing: Bool = false
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if currentlyEditing == true {
            return exercises.count + 1
        } else {
            return exercises.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let exercise = exercises[section]
//        return exercise.name
        for i in 0..<exercises.count {
            if section == i {
                return exercises[i].name
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in 0..<exercises.count {
            if section == i {
                return exercises[i].reps.count
            }
        }
        if section == exercises.count {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section >= exercises.count && currentlyEditing == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addExerciseTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setTableViewCell", for: indexPath) as! SetTableViewCell
            cell.setNumber.text = "Set #\(String(indexPath.row + 1))"
            
//            print(indexPath.section)
//            print(indexPath.row)
            
            cell.repsTextField.text = String(exercises[indexPath.section].reps[indexPath.row])
            print(String(exercises[indexPath.section].reps[indexPath.row]))
            cell.repsTextField.placeholder = "0"
            cell.weightTextField.text = String(exercises[indexPath.section].weights[indexPath.row])
            cell.weightTextField.placeholder = "0"
            
            cell.repsTextField.tag = indexPath.row + 100 * indexPath.section
            cell.weightTextField.tag = (indexPath.row + 100 * indexPath.section) * 2
            
            print("Reps tag number: \(cell.repsTextField.tag)")
            print("Weight tag number: \(cell.weightTextField.tag)")
            
            if !currentlyEditing {
                cell.repsTextField.isUserInteractionEnabled = false
                cell.repsTextField.borderStyle = .none
                cell.weightTextField.isUserInteractionEnabled = false
                cell.weightTextField.borderStyle = .none
            } else {
                cell.repsTextField.isUserInteractionEnabled = true
                cell.repsTextField.borderStyle = .roundedRect
                cell.weightTextField.isUserInteractionEnabled = true
                cell.weightTextField.borderStyle = .roundedRect
            }
            return cell
        }
    }
}
