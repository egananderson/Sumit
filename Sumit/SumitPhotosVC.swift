//
//  SumitPhotosVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit

class SumitPhotosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [UIImage]?
    @IBOutlet weak var spinwheel: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userController = UserController.sharedInstance
        
        if userController.photos == nil {
            //spinwheel.isHidden = false
            //spinwheel.startAnimating()
            
            userController.getSumitPhotos { (success, error) in
                if !success {
                    print("cant get sumit photos")
                } else {
                    DispatchQueue.main.async(execute: {
                        self.collectionView.reloadData()
                        self.spinwheel.hidesWhenStopped = true
                        self.spinwheel.stopAnimating()
                    })
                }
            }
        }
        
        progUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Interface
    
    func progUI() {
        let nib = UINib(nibName: "ImageCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "imageCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let title: String = (UserController.sharedInstance.currentSumit?.title)!
        
        titleLabel.text = title
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UserController.sharedInstance.photos == nil {
            return 0
        } else {
            return (UserController.sharedInstance.photos?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "imageCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCell
        
        let userController = UserController.sharedInstance
        
        if let image = userController.photos?[indexPath.row] {
            cell.sumitImageView.image = image
        }
        
        
        return cell
    }
    
    // MAKR: UICollectionViewDelegateFlowLayout
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - 40
        
        let size = CGSize(width: width, height: width)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let margin: CGFloat = 3.0
        
        return UIEdgeInsets.init(top: margin, left: margin, bottom: margin, right: margin)
    }
    */
    
    // MARK: Methods

    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
