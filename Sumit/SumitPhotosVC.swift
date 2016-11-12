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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSumitPhotos { (success, error) in
            if !success {
                print("cant get sumit photos")
            } else {
                DispatchQueue.main.async(execute: { 
                    self.collectionView.reloadData()
                })
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
        
        
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos == nil {
            return 0
        } else {
            return (photos?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = "imageCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCell
        
        let userController = UserController.sharedInstance
        
        if let image = self.photos?[indexPath.row] {
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
    
    func getSumitPhotos(completion:@escaping (_ success: Bool, _ error: String?) -> Void) {
        // create the session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let did = UserController.sharedInstance.currentSumit?.destinationID
        
        let baseURL : String = Network.apiURL()
        let urlString: String = "\(baseURL)photos_by_did?=\(did!)"
        
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
                print("response was empty get photos for sumit")
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
                    guard let rPhotos = responseDict["photo_urls"] as? [String:Any] else {
                        completion(false, nil)
                        print("Could not get array of destinations from search")
                        return
                    }
                    
                    var photoArray = [UIImage]()
                    
                    for photo in rPhotos {
                        
                        guard let url = rPhotos["photo_url"] as? String else {
                            completion(false, nil)
                            print("Could not get photo")
                            return
                        }
                        
                        let imageData = try? Data(contentsOf: NSURL(string: url) as! URL)
                        
                        let image = UIImage(data: imageData!)!
                        
                        photoArray.append(image)
                    }
                    
                    self.photos = photoArray
                    
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
