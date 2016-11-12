//
//  MapVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController, GMSMapViewDelegate {
    
    // MARK: Properties
    
    var mapView: GMSMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        progUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let latitude = 40.794413
        let longitude = -111.890705
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.tiltGestures = false
        mapView.settings.rotateGestures = false
        //mapView.delegate = self
        mapView.mapType = kGMSTypeTerrain

        view = mapView
    }
    
    // MARK: Interface
    
    func progUI() {
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.white
        
        addDestinations(destinations: MapController.sharedInstance.destinations!)
    }
    
    // MARK: Methods
    
    func addDestinations(destinations: [Destination]) {
        
        for dest in destinations {
            
            let marker = dest.marker
            marker.map = view as! GMSMapView?

            
        }
    }

    // MARK: Google Maps Delegate
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        
        
        return true
    }
}
