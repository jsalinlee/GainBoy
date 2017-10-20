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
                return exercises[i].sets.count
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
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setTableViewCell", for: indexPath) as! SetTableViewCell
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
            cell.setNumber.text = "Set #\(String(indexPath.row + 1))"
            
            cell.repsTextField.text = String(describing: exercises[indexPath.section].sets[indexPath.row][0])
            cell.repsTextField.placeholder = "0"
            cell.repsTextField.tag = (indexPath.row + indexPath.section * 100) + 2
            
            cell.weightTextField.text = String(exercises[indexPath.section].sets[indexPath.row][1])
            cell.weightTextField.placeholder = "0"
            cell.weightTextField.tag = -(indexPath.row + indexPath.section * 100) - 1
//
//            print("Reps tag number: \(cell.repsTextField.tag)")
//            print("Weight tag number: \(cell.weightTextField.tag)")
//
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        exercises[indexPath.section].sets.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        if(exercises[indexPath.section].sets.count <= 0) {
            exercises.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
        }
        tableView.reloadData()
    }
    
}
