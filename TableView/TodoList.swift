//
//  TodoList.swift
//  TableView
//
//  Created by Godhuli on 27/02/23.
//

import Foundation

struct TodoList : Decodable {
    
    var userId : Int
    var id: Int
    var title : String
    var completed: Bool
}
