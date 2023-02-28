//
//  UserTableView1.swift
//  TableView
//
//  Created by Godhuli on 21/02/23.
//

import UIKit

class UserTableView1: UIViewController {
    
    var userInfo = [UserList]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

    }
     
        func fetchData() {
        
        let url = URL(string : "https://jsonplaceholder.typicode.com/users")
        let  dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) -> Void in
            
            guard let data = data , error == nil else {
                
                print(" Error occured while accessing data with url")
                return
            }
            var cList = [UserList]()
            
            do {
                
                cList = try JSONDecoder().decode([UserList].self, from: data)
                
            }
            catch {
                print("Error occured while decoding json into script struct\(error)")
            }
            self.userInfo = cList
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        })
        dataTask.resume()
    }

}

extension UserTableView1: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1).\(userInfo[indexPath.row].name)"
        cell.detailTextLabel?.text = "\(userInfo[indexPath.row].username)"
        return cell
        
    }
    
    
    }
