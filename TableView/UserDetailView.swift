//
//  UserDetailView.swift
//  TableView
//
//  Created by Godhuli on 21/02/23.
//

import UIKit

class UserDetailView: UIViewController {
    @IBOutlet weak var detailsName: UILabel!
    @IBOutlet weak var detailsEmail: UILabel!
    @IBOutlet weak var detailsAddress: UILabel!
    @IBOutlet weak var detailsPhone: UILabel!
    @IBOutlet weak var detailsWebsite: UILabel!
    
    var content:UserList = 
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
