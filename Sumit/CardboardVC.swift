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

    override func viewDidLoad() {
        super.viewDidLoad()

        imageVRView.load(UIImage(named: "EnsignPeak.jpg"),
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
