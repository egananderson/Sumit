//
//  UserController.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import Foundation
import UIKit

let UserIDKey: String = "UserID"
let UsernameKey: String = "UsernameKey"
let ScoreKey: String = "ScoreKey"

class UserController: NSObject {
    
    var currentUser: User?
    var sumits: [Destination]?
    var photoUrl: String?
    var recentSumit: Destination?
    
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
                        print("Could not get userID")
                        return
                    }
                    
                    let user = User(id: userID, user: username, score: 0)
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
        let score = defaults.integer(forKey: ScoreKey)
        
        if (username == nil) {
            // do nothing
        } else {
            
            let user = User(id: userID, user: username!, score: score)
            currentUser = user
        }
    }
    
    func selectSumits(completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let uid = UserController.sharedInstance.currentUser?.userID
        
        let baseURL : String = Network.apiURL()
        let urlString: String = "\(baseURL)sumits_by_uid?uid=\(uid!)"
        
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
                
                // good code
                if statusCode == 0 {
                    guard let rSumits = responseDict["destinations"] as? [[String:Any]] else {
                        completion(false, nil)
                        print("Could not get array of destinations from search")
                        return
                    }
                    
                    var sumitArray = [Destination]()
                    
                    for sumit in rSumits {
                        
                        guard let id = sumit["did"] as? Int else {
                            completion(false, nil)
                            print("Could not get from JSON")
                            return
                        }
                        
                        guard let name = sumit["name"] as? String else {
                            completion(false, nil)
                            print("Could not get name from JSON")
                            return
                        }
                        
                        guard let latitude = sumit["latitude"] as? Double else {
                            completion(false, nil)
                            print("Could not get latitude from JSON")
                            return
                        }
                        
                        guard let longitude = sumit["longitude"] as? Double else {
                            completion(false, nil)
                            print("Could not get longitude from JSON")
                            return
                        }
                        
                        guard let elevation = sumit["elevation"] as? Int else {
                            completion(false, nil)
                            print("Could not get elevation from JSON")
                            return
                        }
                        
                        guard let score = sumit["points"] as? Int else {
                            completion(false, nil)
                            print("Could not get score from JSON")
                            return
                        }

                        
                        /*
                         guard let icon = destDict["icon"] as? String else {
                         completion(false, nil)
                         print("Could not get elevation from JSON")
                         return
                         }
                         */
                        
                        let destination = Destination(id: id, name: name, latitude: latitude, longitude: longitude, elev: elevation, score: score)
                        
                        sumitArray.append(destination)
                    }
                    
                    self.sumits = sumitArray
                    
                    completion(true, nil)
                    
                } else {
                    completion(false, "No adventure created. (Adventure controller)")
                }
                
            } catch  {
                completion(false, nil)
                print("error parsing response from POST pathController->createPath")
                return
            }
        })
        
        dataTask.resume()
    }
    
    // MARK: Update
    
    func saveUserLocal() {
        let defaults = UserDefaults.standard
        
        let userID = currentUser?.userID
        let username = currentUser?.username
        let score = currentUser?.score
        
        defaults.set(userID, forKey: UserIDKey)
        defaults.set(username, forKey: UsernameKey)
        defaults.set(score, forKey: ScoreKey)
        
        defaults.synchronize()
    }
    
    func uploadPhoto(_ image: UIImage, completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
        
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let baseURL = Network.apiURL()
        let urlString : String = "\(baseURL)upload"
        
        // create url using url string
        guard let url = URL(string: urlString) else {
            print("unable to create url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        
        if(imageData == nil) {
            return
        }
        
        
        let body = NSMutableData()
        
        let fileName = self.randomStringWithLength(16) as String
        let mimeType = "image/jpeg"
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(imageData!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            // check for error with task
            guard error == nil else {
                completion(false, nil)
                print(error)
                
                return
            }
            
            // check length of response data
            guard (data?.count)! > 0 else {
                completion(false, nil)
                print("response was empty userController->setProfileImage")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                
                guard let responseDict = try JSONSerialization.jsonObject(with: data!,
                                                                          options: .mutableContainers) as? [String: Any] else {
                                                                            completion(false, nil)
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                
                guard let statusCode = responseDict["statusCode"] as? Int else {
                    completion(false, nil)
                    print("No return code")
                    return
                }
                
                // good code
                if statusCode == 0 {
                    
                    guard let photoUrl = responseDict["photo_url"] as? String else {
                        completion(false, nil)
                        print("No return code")
                        return
                    }
                    
                    let photoGroup = DispatchGroup()
                    
                    photoGroup.enter()
                    
                    self.createSumit(photoUrl: photoUrl, completion: { (success, error) in
                        if !success {
                            print("bad create sumit")
                            completion(false, error)
                        } else {
                            photoGroup.leave()
                        }
                    })
                    
                    photoGroup.notify(queue: DispatchQueue.main, execute: {
                        completion(true, nil)
                    })
                    
                } else {
                    completion(false, "Server error.")
                }
                
            } catch  {
                completion(false, nil)
                print("error parsing response from POST userController->uploadPhoto")
                return
            }
        })
        
        dataTask.resume()
    }
    
    func createSumit(photoUrl: String, completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
    
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let baseURL = Network.apiURL()
        let urlString : String = "\(baseURL)create_sumit"
        
        // create url using url string
        guard let url = URL(string: urlString) else {
            print("unable to create url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let uid = UserController.sharedInstance.currentUser?.userID
        let did = MapController.sharedInstance.currentDestination?.destinationID
        let timestamp = self.timestampString()
        
        print(timestamp)
        
        let params = "uid=\(uid!)&did=\(did!)&photo_url=\(photoUrl)&time=\(timestamp)"
        let postData = params.data(using: String.Encoding.utf8)
        request.httpBody = postData
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            // check for error with task
            guard error == nil else {
                completion(false, nil)
                print(error)
                
                return
            }
            
            // check length of response data
            guard (data?.count)! > 0 else {
                completion(false, nil)
                print("response was empty userController->createNewUser")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let responseDict = try JSONSerialization.jsonObject(with: data!,
                                                                          options: []) as? [String: Any] else {
                                                                            completion(false, nil)
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                
                guard let statusCode = responseDict["statusCode"] as? Int else {
                    completion(false, nil)
                    print("No return code")
                    return
                }
                
                guard let destinationDict = responseDict["destination"] as? NSDictionary else {
                    completion(false, nil)
                    print("No return code")
                    return
                }
                
                // good code
                if statusCode == 0 {
                    // phone has been verified
                    let destination = Destination(id: destinationDict["did"] as! Int, name: destinationDict["name"] as! String, latitude: destinationDict["latitude"] as! Double, longitude: destinationDict["longitude"] as! Double, elev: destinationDict["elevation"] as! Int, score: destinationDict["points"] as! Int)
                    self.sumits?.append(destination)
                    self.recentSumit = destination
                    completion(true, nil)
                    
                } else {
                    completion(false, "mobile number was not verified")
                }
                
            } catch  {
                completion(false, nil)
                print("error parsing response from PUT userContorller->verifyPhone")
                return
            }
        })
        
        dataTask.resume()
        
    }
    
    // MARK: Delete
    
    func logout() {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: UserIDKey)
        defaults.removeObject(forKey: UsernameKey)
        defaults.removeObject(forKey: ScoreKey)
        
        defaults.synchronize()
    }
    
    // MARK: Helpers
    
    // MARK: Helpers
    
    func randomStringWithLength (_ len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        while randomString.length < len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    func timestampString() -> String {
        
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let timestamp = "\(year!)-\(month!)-\(day!) \(hour!):\(minute!):\(second!)"
        
        return timestamp
    }
}
