//
//  UserController.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import Foundation

class UserController: NSObject {
    
    var currentUser: User?
    
    // the singleton for our person controller
    static let sharedInstance = UserController()
    
    fileprivate override init() { }
    
    func createUser(completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let urlString : String = Network.apiURL()
        
        // create url using url string
        guard let url = URL(string: urlString) else {
            print("unable to create url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //let postData = params.data(using: String.Encoding.utf8)
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            // check for error with task
            guard error == nil else {
                completion(false, nil)
                
                return
            }
            
            // check length of response data
            guard (data?.count)! > 0 else {
                completion(false, nil)
                print("response was empty mapController->selectDestinations")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                
                guard let responseDict = try JSONSerialization.jsonObject(with: data!,
                                                                          options: []) as? [String: AnyObject] else {
                                                                            completion(false, nil)
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                
                guard let statusCode = responseDict["statusCode"] as? Int else {
                    completion(false, nil)
                    print("No return code")
                    return
                }
                
                
                if statusCode == 0 {
                    // success
                    completion(true, nil)
                    
                } else {
                    completion(false, "bad call to create user")
                }
                
            } catch  {
                completion(false, nil)
                print("error parsing response create user")
                return
            }
        })
        
        dataTask.resume()
    }
}
