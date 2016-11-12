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
        
        self.navigationController?.isNavigationBarHidden = true
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 80))
        headerView.backgroundColor = UIColor(colorLiteralRed: 19/255, green: 154/255, blue: 228/255, alpha: 1.0)
        
        let leaderButton = UIButton(frame: CGRect(x: 0 , y: 5, width: width/2, height: headerView.frame.height - 5))
        leaderButton.addTarget(self, action: #selector(showLeaderboard), for: .touchUpInside)
        leaderButton.setTitle("Leaderboard", for: .normal)
        leaderButton.setTitleColor(UIColor.white, for: .normal)
        leaderButton.titleLabel?.font = UIFont(name: "System", size: 22)
        leaderButton.titleLabel?.textAlignment = .center
        
        let sumitButton = UIButton(frame: CGRect(x: width/2 , y: 5, width: width/2, height: headerView.frame.height - 5))
        sumitButton.addTarget(self, action: #selector(showUserSumits), for: .touchUpInside)
        sumitButton.setTitle("My Sumits", for: .normal)
        sumitButton.setTitleColor(UIColor.white, for: .normal)
        sumitButton.titleLabel?.font = UIFont(name: "System", size: 22)
        sumitButton.titleLabel?.textAlignment = .center
        
        headerView.addSubview(leaderButton)
        headerView.addSubview(sumitButton)
        
        return headerView
    }
    
    // MARK: Action
    
    func showLeaderboard() {
        let leaderVC = LeaderboardVC()
        self.present(leaderVC, animated: true, completion: nil)
    }
    
    func showUserSumits() {
        let mySumitsVC = MySumitVC()
        self.present(mySumitsVC, animated: true, completion: nil)
    }

    // MARK: Google Maps Delegate
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        return true
    }
    
    // MARK: Transition
    
    func leftToRight() {
        
    }
}
