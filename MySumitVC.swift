//
//  MySumitVC.swift
//  Sumit
//
//  Created by Egan Anderson on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit
import CoreLocation

var locationManager = CLLocationManager();

class MySumitVC: UIViewController {
    @IBOutlet var sumitButton: UIButton!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager();
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        locationManager.startUpdatingLocation();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sumitButtonTapped(_ sender: UIButton) {
        latitudeLabel.text = "\(locationManager.location?.coordinate.latitude)"
        longitudeLabel.text = "\(locationManager.location?.coordinate.longitude)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
