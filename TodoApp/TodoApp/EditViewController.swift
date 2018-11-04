//
//  EditViewController.swift
//  TodoApp
//
//  Created by Jimmy Clark on 10/24/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

//Protocol for editing a task
protocol EditTask{
    func editTask(newName: String, index: Int)
}

class EditViewController: UIViewController {
    
    //Label to display task's current name
    @IBOutlet weak var nameLabel: UILabel!
    //Change button's actions
    @IBAction func change(_ sender: Any) {
        if newName.text != ""{
            delegate?.editTask(newName: newName.text!, index: index)
            navigationController?.popViewController(animated: true)
        }
    }
    
    //User's input
    @IBOutlet weak var newName: UITextField!
    //Delegate to edit tasks in ToDoViewController
    var delegate: EditTask?
    //Name of task being edited
    var label: String = " "
    //index number of task in array
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets label to name of clicked cell
        nameLabel.text = label
    }

    

}
