//
//  LeaderboardVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit

class LeaderboardVC: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var container: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prefersStatusBarHidden
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        container.layer.cornerRadius = 3
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 2
        container.clipsToBounds = true
    }

    // MARK: Actions
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
