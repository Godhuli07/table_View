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
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    var delegate: idDelegate?
    
    
    
    var content:UserList = UserList(id: 0, name: "", username: "", email: "", phone: "", website: "", address: AddressType(street: "", city: "", zipcode: "String"))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.alpha = 1
        secondView.alpha = 0
        
        let ids = content.id
        delegate?.idPassed(ids)
        
        detailsName.text = "Name  : \(content.name)"
        detailsEmail.text = "Email  : \(content.email)"
        detailsPhone.text = "Phone No.  : \(content.phone)"
        detailsWebsite.text = "Website  : \(content.website)"
        detailsAddress.text = "Address  :   \(content.address.city), \(content.address.street)\n\t\t\t Zip - \(content.address.zipcode)"
    }
    @IBAction func switchViews(_sender: UISegmentedControl) {
        if _sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
        }
        else {
            firstView.alpha = 0
            secondView.alpha = 1
        }
        
    }
    
    
}
