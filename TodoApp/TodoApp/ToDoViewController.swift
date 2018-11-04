//
//  ToDoViewController.swift
//  TodoApp
//
//  Created by Jimmy Clark on 10/22/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ClickButton, EditTask {
    
    //Userdata key
    var UDKey = "Todo"
    //initialize userDefaults
    let userDefaults = UserDefaults.standard
    //initialize array of tasks
    var taskArray: [Task] = []
    //holds name of label for preparation
    var indexHolder = 0
    //Task selected to be edited
    var selectedTask: Task?
    
    //Table view to hold tasks
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        //get user data. if it does not exist, use blank task array
        if let stored: Data = UserDefaults.standard.object(forKey: UDKey) as? Data{
        taskArray = try! PropertyListDecoder().decode(Array<Task>.self, from: stored)
        } else {
            taskArray = []
        }
    }
    
    //if clicking checkbox
    func clickButton(checked setTo: Bool, index: Int) {
        checkInArray(setTo: setTo, index: index)
        userDefaults.set(try! PropertyListEncoder().encode(taskArray), forKey: UDKey)
        TableView.reloadData()
    }
    
    //performs checking/unchecking action in array
    func checkInArray(setTo: Bool, index: Int) {
        //swap boolean
        taskArray[index].checked = setTo
    }
    
    //if add button is pressed
    func addTask(name: String) {
        addToArray(name: name)
        UserDefaults.standard.set(try! PropertyListEncoder().encode(taskArray), forKey: UDKey)
        TableView.reloadData()
    }
    
    //adds task to array
    func addToArray(name: String) {
        taskArray.append(Task(name: name))
    }
    
    //if edit button has been pressed
    func editTask(newName: String, index: Int) {
        editInArray(newName: newName, index: index)
        userDefaults.set(try! PropertyListEncoder().encode(taskArray), forKey: UDKey)
        TableView.reloadData()
    }
    
    //edits a task's name in array
    func editInArray(newName: String, index: Int) {
        taskArray[index].name = newName
    }
    
    //preapres for segue to edit or add
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //if adding
        if segue.identifier == "add"{
            let vc = segue.destination as! AddViewController
            vc.delegate = self
        }
        
        //if editing
        if let editVc = segue.destination as? EditViewController {
            editVc.label = selectedTask?.name ?? ""
            editVc.index = indexHolder
            editVc.delegate = self
        }
    }
    
    //if a cell is clicked, make edit segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = taskArray[indexPath.row]
        indexHolder = indexPath.row
        self.performSegue(withIdentifier: "edit", sender: self)
    }
    
    //gives functionality to delete a task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            taskArray.remove(at: indexPath.row)
            userDefaults.set(try! PropertyListEncoder().encode(taskArray), forKey: UDKey)
            TableView.reloadData()
        }
    }
    
    //gives count of tasks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    //prints tasks to tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.taskNameLabel.text = taskArray[indexPath.row].name
        
        if taskArray[indexPath.row].checked{
            let img = UIImage(named: "checkBoxFILLED")
            cell.checkBoxOutlet.setBackgroundImage(img, for: UIControl.State.normal)
        } else {
            let img = UIImage(named: "checkBoxOUTLINE")
            cell.checkBoxOutlet.setBackgroundImage(img, for: UIControl.State.normal)
        }
        
        cell.delegate = self
        cell.indexPath = indexPath.row
        cell.tasks = taskArray
        return cell
    }
}

//task object
class Task: Codable{
    var name = ""
    var checked = false
    
    convenience init(name:String){
        self.init()
        self.name = name
    }
}

