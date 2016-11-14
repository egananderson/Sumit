//
//  SumitController.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import Foundation
import GoogleMaps

class MapController: NSObject {
    
    var mapVC: MapVC?
    var currentDestination: Destination?
    var destinations: [Destination]?
    
    // the singleton for our person controller
    static let sharedInstance = MapController()
    
    fileprivate override init() {
        mapVC = MapVC()
    }
    
    func selectDestinations(completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let baseURL : String = Network.apiURL()
        let urlString: String = "\(baseURL)destinations"
        
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
                    guard let rDestinations = responseDict["destinations"] as? [[String:Any]] else {
                        completion(false, nil)
                        print("Could not get array of destinations from search")
                        return
                    }
                    
                    var destArray = [Destination]()
                    
                    for destDict in rDestinations {
                        
                        guard let id = destDict["did"] as? Int else {
                            completion(false, nil)
                            print("Could not get from JSON")
                            return
                        }
                        
                        guard let name = destDict["name"] as? String else {
                            completion(false, nil)
                            print("Could not get name from JSON")
                            return
                        }
                        
                        guard let latitude = destDict["latitude"] as? Double else {
                            completion(false, nil)
                            print("Could not get latitude from JSON")
                            return
                        }
                        
                        guard let longitude = destDict["longitude"] as? Double else {
                            completion(false, nil)
                            print("Could not get longitude from JSON")
                            return
                        }
                        
                        guard let elevation = destDict["elevation"] as? Int else {
                            completion(false, nil)
                            print("Could not get elevation from JSON")
                            return
                        }
                        
                        guard let score = destDict["points"] as? Int else {
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
                        
                        let destination = Destination(id: id, name: name, latitude: latitude, longitude: longitude, elev: elevation, score: score, faShh: false)
                        
                        destArray.append(destination)
                    }
                    
                    self.destinations = destArray
                    
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
    
    func selectUserDestinations(completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let uid: Int = (UserController.sharedInstance.currentUser?.userID)!
        let baseURL : String = Network.apiURL()
        let urlString: String = "\(baseURL)destinations_by_id?uid=\(uid)"
        
        // create url using url string
        guard let url = URL(string: urlString) else {
            print("unable to create url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
                    guard let rDestinations = responseDict["destinations"] as? [[String:Any]] else {
                        completion(false, nil)
                        print("Could not get array of destinations from search")
                        return
                    }
                    
                    var destArray = [Destination]()
                    
                    for destDict in rDestinations {
                        
                        guard let id = destDict["did"] as? Int else {
                            completion(false, nil)
                            print("Could not get from JSON")
                            return
                        }
                        
                        guard let name = destDict["name"] as? String else {
                            completion(false, nil)
                            print("Could not get name from JSON")
                            return
                        }
                        
                        guard let latitude = destDict["latitude"] as? Double else {
                            completion(false, nil)
                            print("Could not get latitude from JSON")
                            return
                        }
                        
                        guard let longitude = destDict["longitude"] as? Double else {
                            completion(false, nil)
                            print("Could not get longitude from JSON")
                            return
                        }
                        
                        guard let elevation = destDict["elevation"] as? Int else {
                            completion(false, nil)
                            print("Could not get elevation from JSON")
                            return
                        }
                        
                        guard let score = destDict["points"] as? Int else {
                            completion(false, nil)
                            print("Could not get score from JSON")
                            return
                        }
                        
                        guard let faSho = destDict["conquere"] as? Bool else {
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
                        
                        let destination = Destination(id: id, name: name, latitude: latitude, longitude: longitude, elev: elevation, score: score, faShh: faSho)
                        
                        destArray.append(destination)
                    }
                    
                    self.destinations = destArray
                    
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
    
    func findDestination(latitude: Double, longitude: Double) -> Destination? {
        if let destinations = destinations {
            for destination in destinations {
                let radius: Double = 6371 //radius of earth in km
                let lat1 = latitude
                let lat2 = destination.latitude
                let lon1 = longitude
                let lon2 = destination.longitude
                let dLat = (lat2 - lat1) * .pi / 180
                let dLon = (lon2 - lon1) * .pi / 180
                let a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * .pi / 180) * cos(lat2 * .pi / 180) * sin(dLon / 2) * sin(dLon / 2)
                let c = 2 * asin(sqrt(a))
                let km = radius * c
                let meter = km * 1000.0
                if(meter < 100){
                    self.currentDestination = destination
                    return destination
                }
            }
        }
                return nil
    }
}
