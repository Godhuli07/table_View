//
//  UserDetails2.swift
//  TableView
//
//  Created by Godhuli Sarkar on 03/03/23.
//

import UIKit
import CoreData
import Foundation

class UserDetails2: UIViewController {
    
    @IBOutlet weak var displayTodoOrPost: UILabel!
    @IBOutlet weak var displayStatus: UILabel!
    @IBOutlet weak var TodoOrPostHeader: UILabel!
    @IBOutlet weak var statusHeader: UILabel!
    
    
    var todoTitle = ""
    var todoStatus = ""
    var postTitle = ""
    var postBody = ""
    
    var istodo:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        if istodo == true {
            TodoOrPostHeader.text = "Todo :"
            statusHeader.text = "Status :"
            displayTodoOrPost.text = todoTitle
            displayStatus.text = todoStatus
        }
        else
        {
            TodoOrPostHeader.text = "Post :"
            statusHeader.text = "Body :"
            displayTodoOrPost.text = "Title   : \(postTitle)"
            displayStatus.text = "Body    :\(postBody)"
        }
        
    }
}
