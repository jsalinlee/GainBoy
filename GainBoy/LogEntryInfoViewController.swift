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
    @IBOutlet var exerciseList: UITableView!
    @IBOutlet var dateTextField: UITextField!
    
    var date = Date()
    
    var entry: Adventure!
    weak var delegate: AdventureLogViewController?
    
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
        exerciseList.dataSource = LogEntryInfoDataSource()
        dateTextField.inputView = datePicker
        dateTextField.placeholder = dateFormatter.string(from: date)
        timeTextField.inputView = datePicker
        timeTextField.placeholder = timeFormatter.string(from: date)
    }
    
    @IBAction func entryRightBarButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            print("Hooligans")
//            dateFormatter.dateFormat = "HH:mm"
//            let time = dateFormatter.string(from: Date.init())
//            dateFormatter.dateFormat = "mm dd, YYYY"
//            let date = dateFormatter.string(from: Date.init())
        } else if sender.title == "Edit" {
            print("Hulagans")
        }
    }
    
    @IBAction func entryLeftBarButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Cancel" {
            print("Cancel button pressed")
            delegate?.cancelButtonPressed(by: self)
        } else if sender.title == "Back" {
            print("Back button pressed")
        }
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
        }
    }
    
    func timePickerValueChanged(sender: UIDatePicker) {
        timeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    func addLogEntry(title: String, date: Date, time: String, weight: Double, exercises: [Exercise]) {
        
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
