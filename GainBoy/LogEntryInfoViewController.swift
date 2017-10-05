//
//  LogEntryInfoViewController.swift
//  GainBoy
//
//  Created by Jonathan Salin Lee on 6/30/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit

class LogEntryInfoViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    private var sectionNumber = Int()

// MARK: - Outlet Variables
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var lengthTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var allTextFields: [UITextField]!
    @IBOutlet var journalLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
// MARK: - Logistical Variables
    
    var logTitle = String()
    var date = Date()
    var time = Date()
    var weight = Double()
    var logEntry: Adventure!
    var indexPath: IndexPath?
    weak var delegate: AdventureLogViewController?
    
    let logEntryInfoDataSource = LogEntryInfoDataSource()
    var exercises: [Exercise] = []
    
// MARK: - Date and Number Formatters
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf;
    }()
    
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

// MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
//        let fontFamilyNames = UIFont.familyNames
//        for familyName in fontFamilyNames {
//            print("Font Family Name: \(familyName)")
//            let name = UIFont.fontNames(forFamilyName: familyName)
//            print("Font name: \(name)")
//        }
        
        if navigationItem.rightBarButtonItem?.title == "Done" {
            for textField in allTextFields {
                logEntryInfoDataSource.currentlyEditing = true
                self.tableView.reloadData()
                textField.borderStyle = .roundedRect
                textField.isUserInteractionEnabled = true
            }
        } else {
            for textField in allTextFields {
                logEntryInfoDataSource.currentlyEditing = false
                self.tableView.reloadData()
                textField.borderStyle = .none
                textField.isUserInteractionEnabled = false
            }
        }
        
        titleTextField.text = logTitle
        dateTextField.inputView = datePicker
        dateTextField.text = dateFormatter.string(from: date)
        timeTextField.inputView = datePicker
        timeTextField.text = timeFormatter.string(from: time)
        weightTextField.text = String(weight)
        
        journalLabel.attributedText = NSAttributedString(string: "Journal", attributes:
            [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        
        tableView.dataSource = logEntryInfoDataSource
        logEntryInfoDataSource.exercises = exercises
    }
    
// MARK: - Table methods
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        header.backgroundColor = UIColor.white
        
        
        for i in 0..<logEntryInfoDataSource.exercises.count {
            if section == i {
                let headerTitle = UILabel(frame: CGRect(x: 10, y: 0, width: header.frame.width - 100, height: 50))
                headerTitle.text = logEntryInfoDataSource.exercises[i].name
                header.addSubview(headerTitle)
            }
        }
        
        if logEntryInfoDataSource.currentlyEditing == true {
            let addSetButton = AddSetButton(type: UIButtonType.custom) as AddSetButton
            addSetButton.frame = CGRect(x: header.frame.width - 80, y: -5, width: 100, height: 50)
            addSetButton.setTitleColor(header.tintColor, for: .normal)
            addSetButton.setTitle("+", for: .normal)
            
            let biggerFont = addSetButton.titleLabel?.font.withSize(36.0)
            addSetButton.titleLabel?.font = biggerFont
            
            addSetButton.addTarget(self, action: #selector(addSetButtonPressed), for: .touchUpInside)
            addSetButton.section = section
            
            header.addSubview(addSetButton)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < logEntryInfoDataSource.exercises.count {
            return 50
        } else {
            return 0
        }
    }
    
// MARK: - UI Interactions
    
    @objc func addSetButtonPressed(_ sender: AddSetButton) {
        print("Successfully requested to add a set")
        let exerciseIndex = sender.section
        logEntryInfoDataSource.exercises[exerciseIndex].reps.append(0)
        logEntryInfoDataSource.exercises[exerciseIndex].weights.append(0)
        tableView.reloadData()
    }
    
    @IBAction func entryRightBarButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            print("Hooligans")
            
            guard timeTextField.text != "", dateTextField.text != "", weightTextField.text != "" else {
                print("Error, one or more fields left blank")
                return
            }
            logEntryInfoDataSource.currentlyEditing = false
            self.tableView.reloadData()
            
            let timeLog = timeFormatter.date(from: timeTextField.text!)
            let dateLog = dateFormatter.date(from: dateTextField.text!)
            
            delegate?.addAdventure(by: self, t: titleTextField.text!, d: dateLog!, time: timeLog!, w: Double(weightTextField.text!)!, e: logEntryInfoDataSource.exercises, indexPath: indexPath)
            
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.navigationItem.leftBarButtonItem?.title = "Back"
            
            
            for textField in allTextFields {
                textField.borderStyle = .none
                textField.isUserInteractionEnabled = false
            }
            
        } else if sender.title == "Edit" {
            
            logEntryInfoDataSource.currentlyEditing = true
            self.tableView.reloadData()
            
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
    }
    
    @IBAction func addExerciseButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Exercise", message: "Enter the name of your exercise", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            if let exerciseName = alertController.textFields?.first?.text {
                if exerciseName != "" {
                    let newExercise = Exercise(name: exerciseName, reps: [0], weights: [0])
                    self.logEntryInfoDataSource.exercises.append(newExercise)
                    print("Successfully entered a new exercise.")
//                    let newExerciseIndex = self.logEntryInfoDataSource.exercises.index(of: newExercise)
//                    self.tableView.insertSections([newExerciseIndex!], with: .bottom)
                    
                    self.tableView.reloadData()
                }
            }
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
// MARK: - Text Formatting
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag != 0 && textField.text == "0" || textField.tag != 0 && textField.text == "0.0"{
            textField.text = ""
        }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag != 0 && textField.text == "" {
            textField.text = "0"
        }
        let exercises = logEntryInfoDataSource.exercises
        
        guard textField.text != "" else {
            print("textField is empty")
            return
        }
        for i in 0..<exercises.count {
            let reps = logEntryInfoDataSource.exercises[i].reps
//            let weights = logEntryInfoDataSource.exercises[i].weights
            for j in 0..<reps.count {
                if textField.tag == (j + i * 100) + 2 {
                    logEntryInfoDataSource.exercises[i].reps[j] = Int(textField.text!)!
                    return
                }
                if textField.tag == -(j + i * 100) - 1 {
                    let weight = numberFormatter.number(from: textField.text!)
                    logEntryInfoDataSource.exercises[i].weights[j] = (weight?.doubleValue)!
                    return
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current;
        let decimalSeparator = currentLocale.decimalSeparator ?? ".";
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator);
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator);
        
        let onlyDigits = string.rangeOfCharacter(from: NSCharacterSet.letters);
        
        if textField.tag != 0 && existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil || onlyDigits != nil {
            return false;
        } else {
            return true;
        }
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
        timeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
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
