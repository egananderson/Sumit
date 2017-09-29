//
//  Sumit.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import Foundation
import GoogleMaps

class Destination: NSObject {
    
    let destinationID: Int
    let title: String
    let marker: GMSMarker
    let elevation: Int
    let latitude: Double
    let longitude: Double
    let score: Int
    let faSho: Int
    
    init(id: Int, name: String, latitude: Double, longitude: Double, elev: Int, score: Int, faShh: Int) {

        let mapController = MapController.sharedInstance
        
        destinationID = id
        title = name
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = "\(elev) ft"
        
        if faShh == 0 {
            marker.icon = UIImage(named: "eganpin")
            marker.icon = mapController.imageWithImage(image: marker.icon!, scaledToSize: CGSize(width: 60, height: 73))
        } else if faShh == 1{
            marker.icon = UIImage(named: "torypin-1")
            marker.icon = mapController.imageWithImage(image: marker.icon!, scaledToSize: CGSize(width: 60, height: 73))
        } else {
            marker.icon = UIImage(named: "wander_pin")
            marker.icon = mapController.imageWithImage(image: marker.icon!, scaledToSize: CGSize(width: 60, height: 73))
        }
        
        elevation = elev
        self.score = score
        self.latitude = latitude
        self.longitude = longitude
        self.faSho = faShh
    }
    
}
