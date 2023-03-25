//
//  UserDetailView.swift
//  TableView
//
//  Created by Godhuli on 21/02/23.
//

import UIKit
import CoreData


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
    var tList = [TodoList]()
    var pList = [PostList]()
    var todoItem:[TodoListEntity] = []
    var postItem:[PostListEntity] = []
    var str:String = ""
    
    var anyItem:[Any] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    @IBOutlet weak var tpTableView: UITableView!
    
    var taskEnum: TaskEnum = .todo
    var d_name = ""
    var d_email = ""
    var d_phone = ""
    var d_website = ""
    var d_userId:Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchDataTodoPost()
        fetchTodoApi()
        fetchPostApi()
        detailsName.text = "Name       :  \(d_name)"
        detailsEmail.text = "Email      : \(d_email)"
        detailsPhone.text = "Phone No.  : \(d_phone)"
        detailsWebsite.text = "Website    : \(d_website)"
        
        //detailsAddress.text = "Address    :   \(content.address.city), \(content.address.street)\n\t\t\t Zip - \(content.address.zipcode)"
    }
    @IBAction func switchViews(_sender: UISegmentedControl) {
        
        
        if _sender.selectedSegmentIndex == 0 {
            self.taskEnum = .todo
            fetchDataTodoPost()
            
        }
        else {
            self.taskEnum = .post
            fetchDataTodoPost()
            
        }
        
    }
    func fetchTodoApi() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")
        let  tasks = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) -> Void in guard let data = data , error == nil
            else {
                print(" Error occured while accessing data with url")
                return
            }
            do {
                guard let todos = try? JSONDecoder().decode([TodoList].self, from: data)
                else {
                    print("couldnt decode")
                    return
                }
                let todo = todos.filter{$0.userId == self.d_userId}
                
                for todoLoop in todo {
                    let request = NSFetchRequest<TodoListEntity>(entityName: "TodoListEntity")
                    request.predicate = NSPredicate(format: "userId = %@", "\(self.d_userId)")
                    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
                    request.sortDescriptors = [sortDescriptor]
                    let results = try? self.context.fetch(request)
                    if let todoEntity = results?.first {
                        todoEntity.id = Int64(todoLoop.id)
                        todoEntity.title = todoLoop.title
                        todoEntity.userId = Int64(todoLoop.userId)
                        todoEntity.completed = todoLoop.completed
                    }
                    else {
                        let todoEntity = TodoListEntity(context: self.context)
                        todoEntity.id = Int64(todoLoop.id)
                        todoEntity.title = todoLoop.title
                        todoEntity.userId = Int64(todoLoop.userId)
                        todoEntity.completed = todoLoop.completed
                        self.todoItem.append(todoEntity)
                    }
                    
                }
                try self.context.save()
                print("data saved in db")
                DispatchQueue.main.async {
                    self.tpTableView.reloadData()
                }
                
            }
            catch {
                print("Error occured while decoding json into script struct\(error)")
            }
        })
        tasks.resume()
    }
    func fetchPostApi() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let  tasks = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) -> Void in guard let data = data , error == nil
            else {
                print(" Error occured while accessing data with url")
                return
            }
            do {
                guard let posts = try? JSONDecoder().decode([PostList].self, from: data)
                else {
                    print("couldnt decode")
                    return
                }
                let post = posts.filter{$0.userId == self.d_userId}
                
                for postLoop in post {
                    let request = NSFetchRequest<PostListEntity>(entityName: "PostListEntity")
                    request.predicate = NSPredicate(format: "userId = %@", "\(self.d_userId)")
                    let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
                    request.sortDescriptors = [sortDescriptor]
                    let results = try? self.context.fetch(request)
                    if let PostEntity = results?.first {
                        PostEntity.id = Int64(postLoop.id)
                        PostEntity.title = postLoop.title
                        PostEntity.userId = Int64(postLoop.userId)
                        PostEntity.body = postLoop.body
                    }
                    else {
                        let PostEntity = PostListEntity(context: self.context)
                        PostEntity.id = Int64(postLoop.id)
                        PostEntity.title = postLoop.title
                        PostEntity.userId = Int64(postLoop.userId)
                        PostEntity.body = postLoop.body
                        self.postItem.append(PostEntity)
                    }
                    
                }
                try self.context.save()
                print("data saved in db")
                DispatchQueue.main.async {
                    self.tpTableView.reloadData()
                }
                
            }
            catch {
                print("Error occured while decoding json into script struct\(error)")
            }
        })
        tasks.resume()
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
//        let tasks = URLSession.shared.dataTask(with: url! , completionHandler : { (data, response, error) in
//            guard let data = data , error == nil else {
//                print("Error Occured while Accessing Data with url")
//                return
//            }
//            guard let posts = try? JSONDecoder().decode([PostList].self, from: data)
//            else {
//                print("couldnt decode")
//                return
//            }
//            let post = posts.filter{$0.userId == self.d_userId}
//
//            for postLoop in posts {
//                let postEntity = PostListEntity(context: self.context)
//                postEntity.id = Int64(postLoop.id)
//                postEntity.userId = Int64(postLoop.userId)
//                postEntity.title = postLoop.title
//                postEntity.body = postLoop.body
//            }
//            print(post.count)
//            do {
//                try self.context.save()
//                print("data saved in db")
//            }
//            catch {
//                print("error")
//            }
//        })
//        tasks.resume()
    }
    
    func fetchDataTodoPost() {
        switch taskEnum {
        case .todo:

                let request = NSFetchRequest<TodoListEntity>(entityName: "TodoListEntity")
                request.predicate = NSPredicate(format: "userId = %@", "\(self.d_userId)")
                let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
                request.sortDescriptors = [sortDescriptor]
                do {
                    todoItem = try context.fetch(request)
                    print(self.todoItem.count)
                    self.tpTableView.reloadData()
                }
                catch {
                    print("error")
                }

        case .post:
            let request = NSFetchRequest<PostListEntity>(entityName: "PostListEntity")
            request.predicate = NSPredicate(format: "userId = %@", "\(self.d_userId)")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            do {
                postItem = try context.fetch(request)
                print(self.postItem.count)
                self.tpTableView.reloadData()
            }
            catch {
                print("error")
            }

        }
    }
}
                                                    
        
       
extension UserDetailView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch taskEnum {
        case .todo:
            return todoItem.count
        case .post:
            return postItem.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch taskEnum {
        case .todo:
            
            let cell : TodoListCell = tpTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoListCell
            let user = todoItem[indexPath.row]
            cell.todoLabel?.text = user.title
            cell.statusLabel?.text = "\(user.completed)"
            return cell
            
        case .post:
            let cell : TodoListCell = tpTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoListCell
            let user = postItem[indexPath.row]
            cell.todoLabel?.text = user.title
            cell.statusLabel?.text = user.body
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserDetails2") as? UserDetails2
        
        switch taskEnum {
        case .todo:
            let userTodo = todoItem[indexPath.row]
            vc?.todoTitle = userTodo.title!
            vc?.todoStatus = "\(userTodo.completed)"
            vc?.istodo = true
            navigationController?.pushViewController(vc!, animated: true)
        case .post:
            let userPost = postItem[indexPath.row]
            vc?.postTitle = userPost.title!
            vc?.postBody = userPost.body!
            vc?.istodo = false
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
