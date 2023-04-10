//
//  UserTableView1.swift
//  TableView
//
//  Created by Godhuli on 21/02/23.
//

import UIKit
import CoreData
import Foundation

class UserTableView1: UIViewController, UserTappedDelegate {
    func userTapped(id: Int) -> [UserListEntity] {
        return fetchUsersWithId(id: id)
    }
    
        
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var userListLoader: UIActivityIndicatorView!
    
    var userInfo:[UserList] = []
    var items:[UserListEntity] = []
    var address:[AddressEntity] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListLoader.startAnimating()
        self.myTableView.tableFooterView = UIView()
        DispatchQueue.main.async {
            self.fetchData { isSuccess, data in
                if isSuccess{
                    self.fetchUsers { isSuccess in
                        if isSuccess {
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                                self.userListLoader.hidesWhenStopped = true
                                self.userListLoader.stopAnimating()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func fetchUsers(completion : @escaping((Bool) -> Void)) {
        
        let request: NSFetchRequest<UserListEntity> = UserListEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
          request.sortDescriptors = [sortDescriptor]
        do {
            self.items = try!context.fetch(request)
            if items.isEmpty {
            }
            else {
                
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                    
                }
            }
        }
        completion(true)
//        catch {
//            print("error fetching")
//        }
    }
    
    func fetchUsersWithId(id : Int)-> [UserListEntity] {
        var items: [UserListEntity] = []
        let request: NSFetchRequest<UserListEntity> = UserListEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", "\(id)")

        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
          request.sortDescriptors = [sortDescriptor]
        do {
            items = try context.fetch(request)
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
        return items
    }
    
    func fetchData(completion : @escaping((Bool,[UserListEntity])-> Void)) {
        var parsedData : [UserListEntity] = []

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
                        parsedData.append(user)
                        

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
                        parsedData.append(user)

                    }
                }
                try? self.context.save()
                completion(true, parsedData)

                print("user data saved")
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
        detail.delegate = self
        detail.d_userId = Int64(indexPath.row+1)
        self.navigationController?.pushViewController(detail, animated: true)
      }
}
    
