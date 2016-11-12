//
//  User.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import Foundation

class User: NSObject {
    
    let userID: Int
    let username: String
    
    init(id: Int, user: String) {
        
        userID = id
        username = user
        
    }
}
