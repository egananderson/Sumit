//
//  MySumitVC.swift
//  Sumit
//
//  Created by Egan Anderson on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit
import CoreLocation

class MySumitVC: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    var sumits: [Destination]?
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SumitCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "sumitCell")
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
        let userController = UserController.sharedInstance
        usernameLabel.text = userController.currentUser?.username
        usernameLabel.sizeToFit()
        
        let score = String(describing: userController.currentUser!.score)
        scoreLabel.text = "sum: \(score)"
        scoreLabel.sizeToFit()
        
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
    
    
    // MARK: UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.width
        
        let spacing: CGFloat = 3.0
        
        let width: CGFloat = (screenWidth / 3.8)
        
        let size = CGSize(width: width, height: width)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin: CGFloat = 3.0
        
        return UIEdgeInsets.init(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    // MARK: UICollectionViewDatasource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let userController = UserController.sharedInstance
        
        if userController.sumits == nil {
            return 0
        } else {
            return (userController.sumits?.count)!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "sumitCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SumitCell
        
        let userController = UserController.sharedInstance
        
        if let sumit = userController.sumits?[indexPath.row] {
            cell.sumitImage.image = sumit.marker.icon
            cell.titleLabel.text = sumit.title
        }
        
        
        
        
        return cell
    }
    
    // MARK: CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        
        let sumit = UserController.sharedInstance.sumits?[index]
        UserController.sharedInstance.currentSumit = sumit
        
        let sumitPhotosVC = SumitPhotosVC()
        sumitPhotosVC.modalTransitionStyle = .crossDissolve
        
        self.present(sumitPhotosVC, animated: true, completion: nil)
    }

    // MARK: Actions
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
