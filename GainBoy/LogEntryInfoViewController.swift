//
//  LogEntryInfoViewController.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class LogEntryInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var lengthTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var allTextFields: [UITextField]!
    
    @IBOutlet var exerciseList: UITableView!
    
    var date = Date()
    
    var logEntry: Adventure!
    var indexPath: IndexPath?
    weak var delegate: AdventureLogViewController?
    
    let logEntryInfoDataSource = LogEntryInfoDataSource()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("Font Family Name: \(familyName)")
            let name = UIFont.fontNames(forFamilyName: familyName)
            print("Font name: \(name)")
        }
        
        if navigationItem.rightBarButtonItem?.title == "Done" {
            for textField in allTextFields {
                logEntryInfoDataSource.currentlyEditing = true
                self.exerciseList.reloadData()
                textField.borderStyle = .roundedRect
                textField.isUserInteractionEnabled = true
            }
        } else {
            for textField in allTextFields {
                logEntryInfoDataSource.currentlyEditing = false
                self.exerciseList.reloadData()
                textField.borderStyle = .none
                textField.isUserInteractionEnabled = false
            }
        }
        
        exerciseList.dataSource = logEntryInfoDataSource
        exerciseList.delegate = logEntryInfoDataSource
        dateTextField.inputView = datePicker
        dateTextField.text = dateFormatter.string(from: date)
        timeTextField.inputView = datePicker
        timeTextField.text = timeFormatter.string(from: date)
    }
    
    @IBAction func entryRightBarButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            print("Hooligans")
            
            guard timeTextField.text != "", dateTextField.text != "", weightTextField.text != "" else {
                print("Error, one or more fields left blank")
                return
            }
            logEntryInfoDataSource.currentlyEditing = false
            self.exerciseList.reloadData()
            
            let timeLog = timeFormatter.date(from: timeTextField.text!)
            let dateLog = dateFormatter.date(from: dateTextField.text!)
            
            delegate?.addAdventure(by: self, t: titleTextField.text!, d: dateLog!, time: timeLog!, w: Double(weightTextField.text!)!, e: logEntryInfoDataSource.exercises, indexPath: indexPath)
        } else if sender.title == "Edit" {
            
            logEntryInfoDataSource.currentlyEditing = true
            self.exerciseList.reloadData()
            
            for textField in allTextFields {
                textField.borderStyle = .roundedRect
                textField.isUserInteractionEnabled = true
            }
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.navigationItem.leftBarButtonItem?.title = "Cancel"
            print("Hulagans")
        }
    }
    
    @IBAction func entryLeftBarButtonPressed(_ sender: UIBarButtonItem) {
//        if sender.title == "Cancel" {
//            print("Cancel button pressed")
//            delegate?.cancelButtonPressed(by: self)
//        } else if sender.title == "Back" {
//            print("Back button pressed")
        delegate?.cancelButtonPressed(by: self)
//        }
        
        logEntryInfoDataSource.currentlyEditing = false
        self.exerciseList.reloadData()
    }
    
    @IBAction func addExerciseButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Exercise", message: "Enter the name of your exercise", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            if let exerciseName = alertController.textFields?.first?.text {
                if exerciseName != "" {
                    let newExercise = Exercise(name: exerciseName, reps: [], weights: [])
                    self.logEntryInfoDataSource.exercises.append(newExercise)
                    self.exerciseList.reloadData()
                }
            }
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == timeTextField {
            let timePickerView: UIDatePicker = UIDatePicker()
            timePickerView.datePickerMode = UIDatePickerMode.time
            textField.inputView = timePickerView
            timePickerView.addTarget(self, action: #selector(timePickerValueChanged), for: UIControlEvents.valueChanged)
        } else if textField == dateTextField {
            let datePickerView: UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    func timePickerValueChanged(sender: UIDatePicker) {
        timeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
