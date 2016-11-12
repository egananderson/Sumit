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
                
                // good code
                if statusCode == 0 {
                    guard let rDestinations = responseDict["destinations"] as? [[String:Any]] else {
                        completion(false, nil)
                        print("Could not get array of destinations from search")
                        return
                    }
                    
                    var destArray = [Destination]()
                    
                    for destDict in rDestinations {
                        
                        guard let id = destDict["destinationID"] as? Int else {
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
                        
                        guard let icon = destDict["icon"] as? String else {
                            completion(false, nil)
                            print("Could not get elevation from JSON")
                            return
                        }
                        
                        let destination = Destination(id: id, name: name, latitude: latitude, longitude: longitude, elev: elevation)
                    }
                    
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
}
