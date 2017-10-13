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
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var allTextFields: [UITextField]!
    
    @IBOutlet var activeText: UITextField!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Logistical Variables
    
    var backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    var logTitle = String()
    var date = Date()
    var time = Date()
    var weight = Double()
    var logEntry: Quest!
    var indexPath: IndexPath?
    weak var delegate: QuestLogViewController?
    let logEntryInfoDataSource = LogEntryInfoDataSource()
    var exercises: [Exercise] = []
    
// MARK: - Date and Number Formatters
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .none
//        nf.minimumFractionDigits = 0
//        nf.maximumFractionDigits = 1
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
        self.view.backgroundColor = backgroundColor
        self.tableView.backgroundColor = backgroundColor
        
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
        
        tableView.dataSource = logEntryInfoDataSource
        logEntryInfoDataSource.exercises = exercises
        
        // Get keyboard height for when keyboard covers content
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        logEntryInfoDataSource.exercises[exerciseIndex].sets.append([0, 0])
        tableView.reloadData()
    }
    
    @IBAction func entryRightBarButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Done" {
            print("Hooligans")
            
            guard timeTextField.text != "", dateTextField.text != "" else {
                print("Error, one or more fields left blank")
                return;
            }
            
            let timeLog = timeFormatter.date(from: timeTextField.text!)
            let dateLog = dateFormatter.date(from: dateTextField.text!)
            delegate?.addQuest(by: self, t: titleTextField.text!, d: dateLog!, time: timeLog!, e: logEntryInfoDataSource.exercises, indexPath: indexPath)
            
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.navigationItem.leftBarButtonItem?.title = "Back"
            
            logEntryInfoDataSource.currentlyEditing = false
            for textField in allTextFields {
                textField.borderStyle = .none
                textField.isUserInteractionEnabled = false
            }
            
            if (indexPath == nil) {
                delegate?.cancelButtonPressed(by: self)
            }
            
            self.tableView.reloadData()
        } else if sender.title == "Edit" {
            
            logEntryInfoDataSource.currentlyEditing = true
            for textField in allTextFields {
                textField.borderStyle = .roundedRect
                textField.isUserInteractionEnabled = true
            }
            
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.navigationItem.leftBarButtonItem?.title = "Cancel"
            self.tableView.reloadData()
            print("Hulagans")
        }
    }
    
    @IBAction func entryLeftBarButtonPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Cancel" {
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
//            self.navigationItem.leftBarButtonItem?.title = "Back"
//
//            for textField in allTextFields {
//                textField.borderStyle = .none
//                textField.isUserInteractionEnabled = false
//            }
//
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
//            self.navigationItem.leftBarButtonItem?.title = "Back"
//
//            logEntryInfoDataSource.currentlyEditing = false
            let alertController = UIAlertController(title: "", message: "Do you want to discard all of your changes?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                self.delegate?.cancelButtonPressed(by: self)
                print("Cancel button pressed")
            })
            let rejectAction = UIAlertAction.init(title: "No", style: .cancel, handler: nil)
            
            alertController.addAction(rejectAction)
            alertController.addAction(confirmAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else if sender.title == "Back" {
            print("Back button pressed")
            delegate?.cancelButtonPressed(by: self)
        }
    }
    
    @IBAction func addExerciseButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Exercise", message: "Enter the name of your exercise", preferredStyle: .alert)
        
        alertController.addTextField()
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            if let exerciseName = alertController.textFields?.first?.text {
                if exerciseName != "" {
                    let newExercise = Exercise(name: exerciseName, sets: [[0,0]])
                    self.logEntryInfoDataSource.exercises.append(newExercise)
                    print("Successfully entered a new exercise.")
                    
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
            activeText = textField
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
            let sets = logEntryInfoDataSource.exercises[i].sets
            for j in 0..<sets.count {
                if textField.tag == (j + i * 100) + 2 {
                    logEntryInfoDataSource.exercises[i].sets[j][0] = Int(textField.text!)!
                    return
                }
                if textField.tag == -(j + i * 100) - 1 {
                    let weight = numberFormatter.number(from: textField.text!)
                    logEntryInfoDataSource.exercises[i].sets[j][1] = Int(truncating: weight!)
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
    
    // Moves view up when keyboard would cover content
    @objc func keyboardWillShow(note: Notification) {
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var frame = tableView.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.3)
            frame.size.height -= keyboardSize.height
            tableView.frame = frame
            if activeText != nil {
                let rect = tableView.convert(activeText.bounds, from: activeText)
                tableView.scrollRectToVisible(rect, animated: false)
            }
            UIView.commitAnimations()
        }
    }

    // Moves view back down when keyboard is dismissed
    @objc func keyboardWillHide(note: Notification) {
        print("AAHHHH")
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            var frame = tableView.frame
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.3)
            frame.size.height += keyboardSize.height
            tableView.frame = frame
            UIView.commitAnimations()
        }
    }
}
