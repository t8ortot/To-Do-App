//
//  TaskCell.swift
//  TodoApp
//
//  Created by Jimmy Clark on 10/23/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

protocol ClickButton {
    func clickButton(checked: Bool, index: Int)
}

class TaskCell: UITableViewCell {

    //Check box image
    @IBOutlet weak var checkBoxOutlet: UIButton!
    //Name of task
    @IBOutlet weak var taskNameLabel: UILabel!
    //If check box is tapped, invert status
    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexPath!].checked{
            delegate?.clickButton(checked: false, index: indexPath!)
        } else {
            delegate?.clickButton(checked: true, index: indexPath!)
        }
    }
    
    //delegate for checking button
    var delegate: ClickButton?
    //Index path for task checking
    var indexPath: Int?
    //task array
    var tasks: [Task]?
    
}
