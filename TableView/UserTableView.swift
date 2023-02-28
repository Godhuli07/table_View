//
//  UserTableView.swift
//  TableView
//
//  Created by Godhuli on 20/02/23.
//

import UIKit

class UserTableView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    var userInfo = [UserList]()
    
    func fetchData() {
        
        let url = URL(string : "https://jsonplaceholder.typicode.com/users")
        let  dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) -> Void in
            
            guard let data = data , error == nil else{
                print(" Error occured while accessing data with url")
                return
            }
            var cList = [UserList]()
            
            do{
                
                cList = try JSONDecoder().decode([UserList].self, from: data)
                
            }
            catch {
                print("Error occured while decoding json into script struct\(error)")
            }
            self.userInfo = cList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
        dataTask.resume()
    }
    

}
    
