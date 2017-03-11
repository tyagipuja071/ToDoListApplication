//
//  TaskViewController.swift
//  SimpleTableViewController
//
//  Created by Pooja Tyagi on 08/03/17.
//  Copyright © 2017 Pooja Tyagi. All rights reserved.
//

import UIKit


class TaskViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var taskTitleTextfield: UITextField!

    @IBOutlet weak var taskDetailTextfield: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var taskTime: UIDatePicker!
    var task: Task?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitleTextfield.delegate = self
        taskDetailTextfield.delegate = self
        
        // Do this if editing an existing task
        if let task = task {
            navigationItem.title = task.title
            taskTitleTextfield.text   = task.title
            taskDetailTextfield.text = task.detail
           
        }
       updateSaveButtonState()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    
//    func touchesBegan(touches: NSSet, with: UIEvent){
//        self.view.endEditing(true)
//    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
       saveButton.isEnabled = false
       
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
           }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
       if presentingViewController is UINavigationController {
            dismiss(animated: true, completion: nil)
        }
        else {
        _ = navigationController?.popViewController(animated: true)
        }
           }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            
            return
        }
        
        let title = taskTitleTextfield.text ?? ""
        let detail = taskDetailTextfield.text
        let time = taskTime.date
        let notification = UILocalNotification()
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        task = Task(title: title, detail: detail!,time: time,notification: notification)
        let pickerDate = task?.time
        notification.fireDate = pickerDate
        notification.alertBody = task?.title
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.timeZone = TimeZone.current

    
    }
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = taskTitleTextfield.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }


}
