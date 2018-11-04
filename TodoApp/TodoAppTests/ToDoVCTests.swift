//
//  ToDoVCTests.swift
//  TodoAppTests
//
//  Created by Jimmy Clark on 11/3/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import XCTest
@testable import TodoApp

class ToDoVCTests: XCTestCase {
    
    var TodoVC = ToDoViewController()
    
    override func setUp() {
        super.setUp()
        TodoVC.taskArray = []
    }
    
    func test_createTask(){
        let expectedTaskName = "newTask"
        let expectedChecked = false
        
        let newTask = Task(name: "newTask")
        
        XCTAssertEqual((newTask.name == expectedTaskName), (newTask.checked == expectedChecked))
        
    }
    
    func test_addTask(){
        let expectedTask = Task(name: "addTest")
        
        TodoVC.addToArray(name: "addTest")
        
        XCTAssertEqual((expectedTask.name == TodoVC.taskArray[0].name), (expectedTask.checked == TodoVC.taskArray[0].checked))
    }
    
    func test_checking(){
        let expectingTrue = true
        let expectingFalse = false
        
        //will be first element in array
        TodoVC.addToArray(name: "checkTest")
        
        //should be false by default
        let preCheck = TodoVC.taskArray[0].checked
        
        TodoVC.checkInArray(setTo: true, index: 0)
        
        //should be true after checking
        let postCheck = TodoVC.taskArray[0].checked
        
        TodoVC.checkInArray(setTo: false, index: 0)
        
        //should be false after unchecking
        let unCheck = TodoVC.taskArray[0].checked
        
        XCTAssertEqual(((preCheck == expectingFalse) && (unCheck == expectingFalse)), (postCheck == expectingTrue))
    }
    
    func test_editTask(){
        let expectedName = "Do Dishes"
        
        //will be first element in array
        TodoVC.addToArray(name: "Do Laundry")
        
        TodoVC.editInArray(newName: expectedName, index: 0)
        
        XCTAssertEqual(expectedName, TodoVC.taskArray[0].name)
        
        
        
    }
}
