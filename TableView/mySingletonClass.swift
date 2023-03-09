//
//  mySingletonClass.swift
//  TableView
//
//  Created by Godhuli Sarkar on 01/03/23.
//

import Foundation


class TakeId {
    
    static let instance = TakeId()
    
    private init() {
    }
    var ids = 0
    
}
