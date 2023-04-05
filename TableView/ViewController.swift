//
//  ViewController.swift
//  TableView
//
//  Created by Godhuli on 20/02/23.
//

import UIKit


class ViewController: UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    let Login = "USERLOGGEDIN"
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.txtEmail.text = "godhulisarkar@gmail.com"
       self.txtPassword.text = "Godhuli12!!"
        
        if UserDefaults.standard.bool(forKey: Login) == true {
            let signIn = self.storyboard?.instantiateViewController(withIdentifier: "UserTableView1") as! UserTableView1
            self.navigationController?.pushViewController(signIn, animated: true)
        }
        
        //Keyboard tap dismiss
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    

    @IBAction func authenticateUser(_ sender: Any) {
        
        let providedEmailAddress = txtEmail.text ?? ""
        
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: providedEmailAddress)
        
        if isEmailAddressValid {
            
            
            if validpassword(mypassword: txtPassword.text!) {
                
                UserDefaults.standard.set(true, forKey: Login)
                
                let signIn = self.storyboard?.instantiateViewController(withIdentifier: "UserTableView1") as! UserTableView1
                self.navigationController?.pushViewController(signIn, animated: true)
            }
            
            
            else if txtEmail.text?.isEmpty == true && txtPassword.text?.isEmpty == false
            {
                displayAlertMessage(messageToDisplay: "Email field cannot be blank")
            }
            else if txtPassword.text?.isEmpty == true && txtEmail.text?.isEmpty == false
            {
                displayAlertMessage(messageToDisplay: "Password field cannot be blank")
            }
            
            else {
                displayAlertMessage(messageToDisplay: "Password must be more than 6 characters, with at least one capital, numeric or special character")
            }
            
        }
        
        
        else if txtPassword.text?.isEmpty == true && txtEmail.text?.isEmpty == true
        {
            displayAlertMessage(messageToDisplay: "enter email and password")
        }
        
        else
        {
            displayAlertMessage(messageToDisplay: "Email Address not valid!")
        }
        
    }
        
    //Validating email address ----------------------------------------------
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    //Validating Password ---------------------------------------------------
    
    func validpassword(mypassword : String) -> Bool {
        
        let passwordreg =  ("^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
    
    //Display Alert Screen ---------------------------------------------------
    
    func displayAlertMessage(messageToDisplay: String) {
        
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
}

