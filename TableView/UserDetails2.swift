//
//  UserDetails2.swift
//  TableView
//
//  Created by Godhuli Sarkar on 03/03/23.
//

import UIKit

class UserDetails2: UIViewController {
    
    @IBOutlet weak var displayTodoOrPost: UILabel!
    @IBOutlet weak var displayStatus: UILabel!
    @IBOutlet weak var displayBody: UILabel!
    
    var todoTitle = ""
    var todoStatus = ""
    var postTitle = ""
    var postBody = ""
    
    var istodo:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if istodo == true {
<<<<<<< HEAD
            displayBody.text = "Status"
            displayTodoOrPost.text = todoTitle
            displayStatus.text = todoStatus
        }
        else
        {
            displayBody.text = "Body"
            displayTodoOrPost.text = postTitle
            displayStatus.text = postBody
=======
            displayTodoOrPost.text = "Title   : \(todoTitle)"
            displayStatus.text = "Status    :\(todoStatus)"
        }
        else
        {
            displayTodoOrPost.text = "Title   : \(postTitle)"
            displayStatus.text = "Status    :\(postBody)"
>>>>>>> 03eb5c10e1b0a70ef837d209253544a4b497cac8
        }
        
    }
}
