//
//  UserList.swift
//  TableView
//
//  Created by Godhuli on 20/02/23.
//

import Foundation

struct UserList : Decodable {
    
    var id : Int
    var name: String
    var username : String
    var email : String
    var phone : String
    var website : String
    var address : AddressType
    
    
}

struct AddressType : Decodable {
    var street : String
    var city : String
    var zipcode : String
}

        
