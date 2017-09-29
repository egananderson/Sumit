//
//  MySumitVC.swift
//  Sumit
//
//  Created by Egan Anderson on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit
import CoreLocation

class MySumitVC: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var sumits: [Destination]?
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SumitTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "sumitCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.clear
        
        let userController = UserController.sharedInstance
        userController.sumitsVC = self
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Interface methods
    
    func progUI() {
        
    }
    
    @IBAction func sumitButtonTapped(_ sender: UIButton) {
        locationManager = CLLocationManager();
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation();
        
        let mapController = MapController.sharedInstance
        
        if let latitude = locationManager.location?.coordinate.latitude {
            let longitude = locationManager.location!.coordinate.longitude
            print("latitude = \(latitude)")
            print("longitude = \(longitude)")
            if let destination = mapController.findDestination(latitude: latitude, longitude: longitude) {
                print(destination.title)
            } else {
                print("no destination")
            }
        }
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
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // present mountain info vc
        self.tableView.deselectRow(at: indexPath, animated: true)
        let mountainImage: UIImage!
        switch indexPath.row {
        case 0:
            mountainImage = UIImage(named: "ensign_peak")
        case 1:
            mountainImage = UIImage(named: "mt_timpanogas")
        case 2:
            mountainImage = UIImage(named: "grandview-1")
        case 3:
            mountainImage = UIImage(named: "angels_Landing")
        case 4:
            mountainImage = UIImage(named: "El_Capitan")
        case 5:
            mountainImage = UIImage(named: "cape_blanco")
        case 6:
            mountainImage = UIImage(named: "Mt_Baldy")
        case 7:
            mountainImage = UIImage(named: "Mt_Baldy")
        default:
            mountainImage = UIImage(named: "mt_Olympus")
        }
            
        let mountainInfoVC = MountainInfoVC(image: mountainImage)
        
        self.navigationController?.pushViewController(mountainInfoVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "sumitCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SumitTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Ensign Peak"
            cell.numberLabel.text = "x3"
            cell.badgeImageView.image = UIImage.init(named: "ensign_badge")
            cell.image360 = UIImage(named: "EnsignPeak2")!
        case 1:
            cell.nameLabel.text = "Mt. Timpanogas"
            cell.numberLabel.text = "x2"
            cell.badgeImageView.image = UIImage.init(named: "timpanogas_badge")
            cell.image360 = UIImage(named: "timpanogas.jpg")!
        case 2:
            cell.nameLabel.text = "Grandview Peak"
            cell.numberLabel.text = "x1"
            cell.badgeImageView.image = UIImage.init(named: "grandview_badge")
            cell.image360 = UIImage(named: "grandview")!
        case 3:
            cell.nameLabel.text = "Angel's Landing"
            cell.numberLabel.text = "x1"
            cell.badgeImageView.image = UIImage.init(named: "angels_badge")
            cell.image360 = UIImage(named: "angelslanding.jpg")!
        case 4:
            cell.nameLabel.text = "El Capitan"
            cell.numberLabel.text = "x1"
            cell.badgeImageView.image = UIImage.init(named: "elcapitan_badge")
            cell.image360 = UIImage(named: "yosemite")!
        case 5:
            cell.nameLabel.text = "Cape Blanco"
            cell.numberLabel.text = "x1"
            cell.badgeImageView.image = UIImage.init(named: "capeblanco_badge")
            cell.image360 = UIImage(named: "capeBlanco")!
        case 6:
            cell.nameLabel.text = "Mt. Baldy"
            cell.numberLabel.text = "x1"
            cell.badgeImageView.image = UIImage.init(named: "baldy_badge")
            cell.image360 = UIImage(named: "baldy")!
        case 7:
            cell.nameLabel.text = "Games For Health"
            cell.numberLabel.text = "x1"
            cell.badgeImageView.image = UIImage.init(named: "timpanogas_badge")
            cell.image360 = UIImage(named: "saltair")!
        default:
            cell.nameLabel.text = "Mt. Olympus"
            cell.numberLabel.text = "x3"
            cell.badgeImageView.image = UIImage.init(named: "olympus_badge")
            cell.image360 = UIImage(named: "olympus.jpg")!
        }

        cell.backgroundColor = UIColor.clear
        return cell
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
