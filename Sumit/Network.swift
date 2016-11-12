//
//  Network.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import Foundation

class Network: NSObject {
    
    override init() {
        super.init()
    }
    
    class func apiURL() -> String {
        return "https://sumit-149304.appspot.com/"
    }
}
