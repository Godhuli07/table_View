//
//  UserPostView.swift
//  TableView
//
//  Created by Godhuli on 27/02/23.
//

import UIKit

class UserPostView: UIViewController {
    
    var postData = [PostList]()

    @IBOutlet weak var postTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTableView.tableFooterView = UIView()
        fetchData2()
    }
    func fetchData2 () {
        let urlPost = URL(string: "https://jsonplaceholder.typicode.com/posts")
        let dataTask2 = URLSession.shared.dataTask(with: urlPost!, completionHandler: { (data, response, error) in
            guard let data = data , error == nil else {
                print("Error Occured while Accessing Data with url")
                return
            }
            var pList = [PostList]()
            do {
                pList = try JSONDecoder().decode([PostList].self, from: data)
            }
            catch {
                print("Error while decoding \(error)")
            }
            self.postData = pList
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        })
        dataTask2.resume()
    }
}
extension UserPostView: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PostListCell = postTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostListCell
        cell.postTitle.text = "\(indexPath.row+1).\(postData[indexPath.row].title)"
        cell.postBody.text = "\(postData[indexPath.row].body)"
        return cell
    }
    
}
