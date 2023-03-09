//
//  UserDetails2.swift
//  TableView
//
//  Created by Godhuli Sarkar on 03/03/23.
//

import UIKit

class UserDetails2: UIViewController {
    
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayTodoOrPost: UILabel!
    @IBOutlet weak var displayStatus: UILabel!
    
    
    var displayDetails:TodoList = TodoList(userId: 0, id: 0, title: "", completed: true)
    var displayDetails2:PostList = PostList(userId: 0, id: 0, title: "", body: "")
    var istodo:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if istodo == true {
            displayName.text = "User Id : \(displayDetails.userId)"
            displayTodoOrPost.text = "Todo : \(displayDetails.title)"
            displayStatus.text = "Status : \(displayDetails.completed)"
        }
        else
        {
            displayName.text = "User Id : \(displayDetails2.userId)"
            displayTodoOrPost.text = "Post : \(displayDetails2.title)"
            displayStatus.text = "Body : \(displayDetails2.body)"
        }
        
    }
}
