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
        self.myTableView.tableFooterView = UIView()
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
                self.userInfo = cList
                
            }
            catch {
                print("Error occured while decoding json into script struct\(error)")
            }
            
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
      let cell : TableViewCell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
      cell.nameList.text = "\(indexPath.row+1).\(userInfo[indexPath.row].name)"
      cell.usernameList.text = "\(userInfo[indexPath.row].username)"
      return cell
     
      }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetailView") as? UserDetailView
        vc?.content = userInfo[indexPath.row]
        TakeId.instance.ids = indexPath.row + 1
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    

}
    
