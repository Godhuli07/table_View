//
//  UserTableView1.swift
//  TableView
//
//  Created by Godhuli on 21/02/23.
//

import UIKit
import CoreData
import Foundation

class UserTableView1: UIViewController {
        
    @IBOutlet weak var myTableView: UITableView!
    
    var userInfo:[UserList] = []
    var items:[UserListEntity] = []
    var address:[AddressEntity] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.tableFooterView = UIView()
<<<<<<< HEAD
        DispatchQueue.main.async {
            self.fetchData { isSuccess, data in
                if isSuccess{
                    self.fetchUsers()
                }
            }

        }
                
    }
    func fetchUsers() {
        let request: NSFetchRequest<UserListEntity> = UserListEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
          request.sortDescriptors = [sortDescriptor]
        do {
            self.items = try context.fetch(request)
            if items.isEmpty {
            }
            else {
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                
            }
        }
        catch {
            print("error fetching")
        }
=======
//        fetchUsers()
        fetchData()
>>>>>>> 03eb5c10e1b0a70ef837d209253544a4b497cac8
    }
    
    func fetchUsers() {
        let request: NSFetchRequest<UserListEntity> = UserListEntity.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
        do {
            self.items = try context.fetch(request)
            if items.isEmpty {
                fetchData()
            }
            else {
                self.myTableView.reloadData()
            }
        }
        catch {
            print("error fetching")
        }
    }
     
<<<<<<< HEAD
    func fetchData(completion : @escaping((Bool,[UserListEntity])-> Void)) {
        var parsedData : [UserListEntity] = []
=======
    func fetchData() {
        
>>>>>>> 03eb5c10e1b0a70ef837d209253544a4b497cac8
        let url = URL(string : "https://jsonplaceholder.typicode.com/users")
        let  dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) -> Void in guard let data = data , error == nil
            else {
                print(" Error occured while accessing data with url")
                return
            }
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                for dictionary in jsonArray {
                    let request: NSFetchRequest<UserListEntity> = UserListEntity.fetchRequest()
                    request.predicate = NSPredicate(format: "id == %i", dictionary["id"] as! Int64)
                  let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
                    request.sortDescriptors = [sortDescriptor]
                    let results = try? self.context.fetch(request)
                    
                    if let user = results?.first {
                        user.name = dictionary["name"] as? String
                        user.username = dictionary["username"] as? String
                        user.email = dictionary["email"] as? String
                        //user.address = dictionary["address"] as? String
                        user.website = dictionary["website"] as? String
                        user.phone = dictionary["phone"] as? String
<<<<<<< HEAD
                        parsedData.append(user)
                        
=======
>>>>>>> 03eb5c10e1b0a70ef837d209253544a4b497cac8
                    }
                    else {
                        let user = UserListEntity(context: self.context)
                        user.id = dictionary["id"] as? Int64 ?? 0
                        user.name = dictionary["name"] as? String
                        user.username = dictionary["username"] as? String
                        user.email = dictionary["email"] as? String
                        user.phone = dictionary["phone"] as? String
                       // user.address = dictionary["address"] as? String
                        user.website = dictionary["website"] as? String
<<<<<<< HEAD
                        parsedData.append(user)
=======
//                        self.items.append(user)
>>>>>>> 03eb5c10e1b0a70ef837d209253544a4b497cac8
                    }
                }
                //cList = try JSONDecoder().decode([UserList].self, from: data)
                //self.userInfo = cList
                //Saving data
                try? self.context.save()
<<<<<<< HEAD
                completion(true, parsedData)
=======
>>>>>>> 03eb5c10e1b0a70ef837d209253544a4b497cac8
                print("data saved")
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
            catch {
                print("Error occured while decoding json into script struct\(error)")
            }
        })
        dataTask.resume()
    }
    
    

}

extension UserTableView1: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell : TableViewCell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let user = items[indexPath.row]
      cell.nameList?.text = user.name
      cell.usernameList?.text = user.username
      return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let detail: UserDetailView = self.storyboard?.instantiateViewController(identifier: "UserDetailView") as!
              UserDetailView
        let user = items[indexPath.row]
        detail.d_name = user.name!
        detail.d_email = user.email!
        detail.d_phone = user.phone!
<<<<<<< HEAD
        
=======
>>>>>>> 03eb5c10e1b0a70ef837d209253544a4b497cac8
        detail.d_website = user.website!
        detail.d_userId = user.id
        self.navigationController?.pushViewController(detail, animated: true)
      }
}
    
