//
//  ChallengImageVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 3/29/17.
//  Copyright © 2017 via cole. All rights reserved.
//

import UIKit

class ChallengImageVC: UIViewController {
    
    var imageView = UIImageView()
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
