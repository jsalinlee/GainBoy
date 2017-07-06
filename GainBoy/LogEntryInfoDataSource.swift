//
//  LogEntryInfoDataSource.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 7/3/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class LogEntryInfoDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
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
                return exercises[i].reps.count + 1
            }
        }
        if section == exercises.count {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        header.backgroundColor = UIColor.white
        
        
        for i in 0..<exercises.count {
            if section == i {
                let headerTitle = UILabel(frame: CGRect(x: 10, y: 0, width: header.frame.width - 100, height: 50))
                let font = UIFont(name: "Kirby\'s-Adventure", size: 20)
                headerTitle.font = font
                headerTitle.text = exercises[i].name
                header.addSubview(headerTitle)
            }
        }
        
        if currentlyEditing == true {
            let addSetButton = UIButton(type: UIButtonType.custom) as UIButton
            addSetButton.frame = CGRect(x: header.frame.width - 80, y: -5, width: 100, height: 50)
            addSetButton.addTarget(self, action: #selector(addSetButtonPressed), for: .touchUpInside)
            addSetButton.setTitleColor(header.tintColor, for: .normal)
            
            let biggerFont = addSetButton.titleLabel?.font.withSize(36.0)
            addSetButton.titleLabel?.font = biggerFont
            
            addSetButton.setTitle("+", for: .normal)
            
            
            header.addSubview(addSetButton)
            
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < exercises.count {
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == exercises.count && currentlyEditing == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addExerciseTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "setTableViewCell", for: indexPath) as! SetTableViewCell
            cell.setNumber.text = "Set #\(String(indexPath.row + 1))"
            cell.repsTextField.placeholder = "0"
            cell.weightTextField.placeholder = "0"
            return cell
        }
    }
    
    func addSetButtonPressed(_ sender: UIButton) {
        print("Successfully requested to add a set")
        
    }
}
