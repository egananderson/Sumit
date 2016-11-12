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
    let score: Int
    
    init(id: Int, user: String, score: Int) {
        
        userID = id
        username = user
        self.score = score
        
    }
}
