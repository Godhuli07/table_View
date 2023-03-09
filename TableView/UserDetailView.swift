//
//  UserDetailView.swift
//  TableView
//
//  Created by Godhuli on 21/02/23.
//

import UIKit

enum TaskEnum: Int16 {
    case todo = 0
    case post = 1
}

class UserDetailView: UIViewController {
    @IBOutlet weak var detailsName: UILabel!
    @IBOutlet weak var detailsEmail: UILabel!
    @IBOutlet weak var detailsAddress: UILabel!
    @IBOutlet weak var detailsPhone: UILabel!
    @IBOutlet weak var detailsWebsite: UILabel!
    
    var todoData = [TodoList]()
    var postData = [PostList]()
    var filterTodo = [TodoList]()
    var filterPost = [PostList]()
    
    @IBOutlet weak var tpTableView: UITableView!
    
   var taskEnum: TaskEnum = .todo
    
    var content:UserList = UserList(id: 0, name: "", username: "", email: "", phone: "", website: "", address: AddressType(street: "", city: "", zipcode: "String"))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData1()
        detailsName.text = "Name       : \(content.name)"
        detailsEmail.text = "Email      : \(content.email)"
        detailsPhone.text = "Phone No.  : \(content.phone)"
        detailsWebsite.text = "Website    : \(content.website)"
        detailsAddress.text = "Address    :   \(content.address.city), \(content.address.street)\n\t\t\t Zip - \(content.address.zipcode)"
    }
    @IBAction func switchViews(_sender: UISegmentedControl) {
       
        
        if _sender.selectedSegmentIndex == 0 {
            
            self.taskEnum = .todo
            fetchData1()

      }
        else {
            self.taskEnum = .post
            fetchData1()

      }
        
    }
  
    func fetchData1() {
        var tList = [TodoList]()
        var pList = [PostList]()

        let url = self.taskEnum == .todo ? "https://jsonplaceholder.typicode.com/todos" : "https://jsonplaceholder.typicode.com/posts"
        let urlTodo = URL(string : url)
        switch taskEnum {
        case .todo:

            let dataTask1 = URLSession.shared.dataTask(with: urlTodo! , completionHandler : { (data, response, error) in
                guard let data = data , error == nil else {
                    print("Error Occured while Accessing Data with url")
                    return
                }
                do {
                    tList = try JSONDecoder().decode([TodoList].self, from: data)
                    self.todoData = tList
                    for filterTodo in self.todoData {
                        if (filterTodo.userId == TakeId.instance.ids) {
                            self.filterTodo.append(filterTodo)
                        }
                    }
                }
                catch {
                    print("Error while decoding \(error)")
                }
                DispatchQueue.main.async {
                    self.tpTableView.reloadData()
                }
            })
            dataTask1.resume()
        case .post:
            let dataTask1 = URLSession.shared.dataTask(with: urlTodo! , completionHandler : { (data, response, error) in
                guard let data = data , error == nil else {
                    print("Error Occured while Accessing Data with url")
                    return
                }
                do {
                    pList = try JSONDecoder().decode([PostList].self, from: data)
                    self.postData = pList
                    for filterPost in self.postData {
                        if (filterPost.userId == TakeId.instance.ids) {
                            self.filterPost.append(filterPost)
                        }
                    }
                }
                catch {
                    print("Error while decoding \(error)")
                }
                DispatchQueue.main.async {
                    self.tpTableView.reloadData()
                }
            })
            dataTask1.resume()
        }

    }
    
//    func fetchData1() {
//        var tList = [TodoList]()
//        var pList = [PostList]()
//
//        let url = self.taskEnum == .todo ? "https://jsonplaceholder.typicode.com/todos" : "https://jsonplaceholder.typicode.com/posts"
//        let urlTodo = URL(string : url)
//
//
//            let dataTask1 = URLSession.shared.dataTask(with: urlTodo! , completionHandler : { (data, response, error) in
//                guard let data = data , error == nil else {
//                    print("Error Occured while Accessing Data with url")
//                    return
//                }
//                switch taskEnum {
//                case .todo:
//                    do {
//                        tList = try JSONDecoder().decode([TodoList].self, from: data)
//                        self.todoData = tList
//                        for filterTodo in self.todoData {
//                            if (filterTodo.userId == TakeId.instance.ids) {
//                                self.filterTodo.append(filterTodo)
//                            }
//                        }
//                        catch {
//                            print("Error while decoding \(error)")
//                        }
//                    }
//                case .post:
//                    do {
//                        pList = try JSONDecoder().decode([PostList].self, from: data)
//                        self.postData = pList
//                        for filterPost in self.postData {
//                            if (filterPost.userId == TakeId.instance.ids) {
//                                self.filterPost.append(filterPost)
//                            }
//                        }
//                    }
//                    catch {
//                        print("Error while decoding \(error)")
//                    }
//                }
//
//                DispatchQueue.main.async {
//                    self.tpTableView.reloadData()
//                }
//            })
//            dataTask1.resume()
//        }
}
extension UserDetailView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch taskEnum {
        case .todo:
            return filterTodo.count
        case .post:
            return filterPost.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch taskEnum {
        case .todo:
            
            let cell : TodoListCell = tpTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoListCell
            cell.todoLabel.text = "\(indexPath.row+1).\(filterTodo[indexPath.row].title)"
            cell.statusLabel.text = "\(filterTodo[indexPath.row].completed)"
            return cell
            
        case .post:
            let cell : TodoListCell = tpTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoListCell
            cell.todoLabel.text = "\(indexPath.row+1).\(filterPost[indexPath.row].title)"
            cell.statusLabel.text = "\(filterPost[indexPath.row].body)"
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetails2") as? UserDetails2
        switch taskEnum {
        case .todo:
            vc?.displayDetails = filterTodo[indexPath.row]
            vc?.istodo = true
            TakeId.instance.ids = indexPath.row + 1
            navigationController?.pushViewController(vc!, animated: true)
        case .post:
            vc?.displayDetails2 =  filterPost[indexPath.row]
            TakeId.instance.ids = indexPath.row + 1
            navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
}

