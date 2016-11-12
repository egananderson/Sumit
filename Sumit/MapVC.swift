//
//  MapVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: Properties
    
    var mapView: GMSMapView?
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        progUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        loadLocation()
        
        let latitude = locationManager.location!.coordinate.latitude
        let longitude = locationManager.location!.coordinate.longitude
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
        
        if let destinations = MapController.sharedInstance.destinations {
            addDestinations(destinations: destinations)
        }
        
        let header = getHeaderView()
        
        view.addSubview(header)
    }
    
    // MARK: Methods
    
    func addDestinations(destinations: [Destination]) {
        
        for dest in destinations {
            
            let marker = dest.marker
            marker.map = view as! GMSMapView?

            
        }
    }
    
    func getHeaderView() -> UIView {
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        // make header container
        let headerView = UIView(frame: CGRect(x: 0, y: height - 80, width: width, height: 80))
        headerView.backgroundColor = UIColor(colorLiteralRed: 19/255, green: 154/255, blue: 228/255, alpha: 1.0)
        
        let iconHeight = headerView.frame.height - 30
        
        let leaderButton = UIButton(frame: CGRect(x: 3*width/15 - iconHeight , y: 15, width: iconHeight, height: iconHeight))
        leaderButton.addTarget(self, action: #selector(showLeaderboard), for: .touchUpInside)
        leaderButton.setImage(UIImage(named: "leaderboard.png"), for: .normal)
        
        let sumitButton = UIButton(frame: CGRect(x: 12*width/15 , y: 19, width: iconHeight*0.8, height: iconHeight*0.8))
        sumitButton.addTarget(self, action: #selector(showUserSumits), for: .touchUpInside)
        sumitButton.setImage(UIImage(named: "trophy.png"), for: .normal)
        
        headerView.addSubview(leaderButton)
        headerView.addSubview(sumitButton)
        
        let centerIconHeight = 4*iconHeight/3
        
        let recordSumitButton = UIButton(frame: CGRect(x: width/2 - ((centerIconHeight)*1.7737/2) , y: 5, width: (centerIconHeight)*1.7737, height: centerIconHeight))
        recordSumitButton.addTarget(self, action: #selector(showRecordSumit), for: .touchUpInside)
        recordSumitButton.setImage(UIImage(named: "sumitfulltext.png"), for: .normal)
        
        headerView.addSubview(recordSumitButton)
        
        return headerView
    }
    
    // MARK: Action
    
    func showLeaderboard() {
        let leaderVC = LeaderboardVC()
        self.present(leaderVC, animated: true, completion: nil)
    }
    
    func showUserSumits() {
        
        let userController = UserController.sharedInstance
        
        let mySumitsVC = MySumitVC()
        self.present(mySumitsVC, animated: true, completion: nil)

    }
    
    func showRecordSumit() {
        loadLocation()
        
        let mapController = MapController.sharedInstance
        
        if let latitude = locationManager.location?.coordinate.latitude {
            let longitude = locationManager.location!.coordinate.longitude
            print("latitude = \(latitude)")
            print("longitude = \(longitude)")
            if let destination = mapController.findDestination(latitude: latitude, longitude: longitude) {
                print(destination.title)
                let cameraVC = CameraVC()
                let navigationController = UINavigationController(rootViewController: cameraVC)
                self.present(navigationController, animated: true, completion: nil)
            } else {
                print("no destination")
            }
        }

    }

    // MARK: Google Maps Delegate
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        return true
    }
    
    // MARK: Transition
    
    func leftToRight() {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
    func loadLocation() {
        locationManager = CLLocationManager();
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation();
    }
}
