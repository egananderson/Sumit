//
//  UserController.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import Foundation

let UserIDKey: String = "UserID"
let UsernameKey: String = "UsernameKey"

class UserController: NSObject {
    
    var currentUser: User?
    
    // the singleton for our person controller
    static let sharedInstance = UserController()
    
    fileprivate override init() { }
    
    // MARK: Create
    
    func createUser(username: String, completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let baseURL: String = Network.apiURL()
        let urlString: String = "\(baseURL)create_user"
        
        // create url using url string
        guard let url = URL(string: urlString) else {
            print("unable to create url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let params = "username=\(username)"
        let postData = params.data(using: String.Encoding.utf8)
        request.httpBody = postData
        
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
                    
                    guard let userID = responseDict["uid"] as? Int else {
                        completion(false, nil)
                        print("Could not get username")
                        return
                    }
                    
                    let user = User(id: userID, user: username)
                    self.currentUser = user
                    self.saveUserLocal()
                    
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
    
    // MARK: Read
    
    func loadUserLocal() {
        let defaults = UserDefaults.standard
        
        let userID = defaults.integer(forKey: UserIDKey)
        let username = defaults.string(forKey: UsernameKey)
        
        if (username == nil) {
            // do nothing
        } else {
            
            let user = User(id: userID, user: username!)
            currentUser = user
        }
    }
    
    // MARK: Update
    
    func saveUserLocal() {
        let defaults = UserDefaults.standard
        
        let userID = currentUser?.userID
        let username = currentUser?.username
        
        defaults.set(userID, forKey: UserIDKey)
        defaults.set(username, forKey: UsernameKey)
        
        defaults.synchronize()
    }
    
    // MARK: Delete
    
    func logout() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: UserIDKey)
        defaults.removeObject(forKey: UsernameKey)
        
        defaults.synchronize()
    }
}
