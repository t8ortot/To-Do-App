//
//  AddViewController.swift
//  TodoApp
//
//  Created by Jimmy Clark on 10/24/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

//Protocol for adding a task
protocol AddTask {
    func addTask(name: String)
}

class AddViewController: UIViewController {
    
    //User's input for task name
    @IBOutlet weak var NameOutlet: UITextField!
    //Add button's action
    @IBAction func AddAction(_ sender: Any) {
        if NameOutlet.text != "" {
            delegate?.addTask(name: NameOutlet.text!)
            navigationController?.popViewController(animated: true)
        }
    }
    //Delegate to add task in ToDoViewController
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
