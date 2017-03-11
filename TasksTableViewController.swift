//
//  TasksTableViewController.swift
//  SimpleTableViewController
//
//  Created by Pooja Tyagi on 08/03/17.
//  Copyright © 2017 Pooja Tyagi. All rights reserved.
//

import UIKit



class TasksTableViewController: UITableViewController {
    
    var tasks = [Task]()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let savedTasks = loadTasks(){
        tasks += savedTasks
        }
        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame:.zero)
        self.tableView.separatorColor = UIColor.darkGray
        self.tableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskInfoCell", for: indexPath) as! TasksCell
        let task = tasks[indexPath.row]
        cell.taskTitle.text = task.title
        cell.taskDetail.text = task.detail
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        cell.taskTimeLabel.text = dateFormatter.string(from: task.time)
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
            if editingStyle == .delete {
                // Delete the row from the data source
                self.tasks.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                saveTasks()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }    
        }
        
        
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = tasks.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    @IBAction func unwindTotaskTableVC(sender: UIStoryboardSegue){
        
        
        if let sourceViewController = sender.source as? TaskViewController, let task = sourceViewController.task {
              if let selectedIndexPath = tableView.indexPathForSelectedRow{
            tasks[selectedIndexPath.row] = task
            saveTasks()
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
            
        }
            
    else {
            let newIndexpath = IndexPath(row: tasks.count,section: 0)
            print(task)
            tasks.append(task)
            tableView.insertRows(at: [newIndexpath], with: .none)
            saveTasks()
            tableView.reloadData()
        }
            
            let pickerdate = sourceViewController.taskTime.date
            let notification = UILocalNotification()
            notification.fireDate = pickerdate
            notification.alertBody = sourceViewController.taskTitleTextfield.text
            notification.alertAction = "Shoe me the task!!!"
            notification.timeZone = TimeZone.current
            UIApplication.shared.scheduleLocalNotification(notification)
            
        }
    }
   
    
    
    
    // MARK: - prepareForSegue
    
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTaskSegue" {
            
                }
        
        
        else if segue.identifier == "editTaskSegue"{
            let tasksVC = segue.destination as? TaskViewController
        let selectedTaskCell = sender as? TasksCell
        let indexpath = tableView.indexPath(for: selectedTaskCell!)
            let selectedTask = tasks[(indexpath?.row)!]
            tasksVC?.task = selectedTask
            
        
        }
        
    }
    
    func saveTasks(){
     let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path)
        if isSuccessfulSave{
        print("%%%% Save is Successfull %%%%")
        }
        else{
         print("%%%% Save FAILED!!! %%%%")
        }
    }
    
    func loadTasks() -> [Task]? {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Task.ArchiveURL.path) as? [Task]
    
    }

    
}
