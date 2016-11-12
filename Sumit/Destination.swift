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
    
    init(id: Int, name: String, latitude: Double, longitude: Double, elev: Int, score: Int) {

        destinationID = id
        title = name
        marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = "Salt Lake City"
        marker.icon = UIImage(named: "sumitlogo.png")
        elevation = elev
        self.score = score
        self.latitude = latitude
        self.longitude = longitude
    }
}
