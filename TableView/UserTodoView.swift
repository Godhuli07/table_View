//
//  UserTodoView.swift
//  TableView
//
//  Created by Godhuli on 27/02/23.
//

import UIKit

class UserTodoView: UIViewController {
    
    var todoData = [TodoList]()
    var filterTodo = [TodoList]()
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.todoTableView.tableFooterView = UIView()
        fetchData1()
    }
    func fetchData1() {
        let urlTodo = URL(string : "https://jsonplaceholder.typicode.com/todos" )
        let dataTask1 = URLSession.shared.dataTask(with: urlTodo! , completionHandler : { (data, response, error) in
            guard let data = data , error == nil else {
                print("Error Occured while Accessing Data with url")
                return
            }
            var tList = [TodoList]()
            do {
                tList = try JSONDecoder().decode([TodoList].self, from: data)
                self.todoData = tList
                for filterTodo in self.todoData {
                    if (filterTodo.userId == 1) {
                        self.filterTodo.append(filterTodo)                    }
                        
                }
            }
            catch {
                print("Error while decoding \(error)")
            }
            DispatchQueue.main.async {
                self.todoTableView.reloadData()
            }
        })
        dataTask1.resume()
    }
}
extension UserTodoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTodo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TodoListCell = todoTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoListCell
        cell.todoLabel.text = "\(indexPath.row+1).\(filterTodo[indexPath.row].title)"
        cell.statusLabel.text = "\(filterTodo[indexPath.row].completed)"
        return cell
       
    }
}

protocol idDelegate {
    func idPassed(_ ids: Int)
}
        

