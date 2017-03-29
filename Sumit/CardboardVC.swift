//
//  CardboardVC.swift
//  Sumit
//
//  Created by Egan Anderson on 2/17/17.
//  Copyright © 2017 via cole. All rights reserved.
//

import UIKit

class CardboardVC: UIViewController {

    @IBOutlet var imageVRView: GVRPanoramaView!
    public var image360: UIImage
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        image360 = UIImage()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageVRView.load(image360,
                         of: GVRPanoramaImageType.mono)
        imageVRView.enableCardboardButton = true
        imageVRView.enableFullscreenButton = false
        imageVRView.enableTouchTracking = true
        imageVRView.isMultipleTouchEnabled = true
        imageVRView.isUserInteractionEnabled = true
    }
    
    func loadImage(image360: UIImage) {
        imageVRView.load(image360,
                         of: GVRPanoramaImageType.mono)
        imageVRView.enableCardboardButton = true
        imageVRView.enableFullscreenButton = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissVC(_ sender: Any) {
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
