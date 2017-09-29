//
//  MountainInfoVC.swift
//  Sumit
//
//  Created by Egan Anderson on 3/29/17.
//  Copyright © 2017 via cole. All rights reserved.
//

import UIKit

class MountainInfoVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var mountainImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = mountainImage
    }
    
    init(image: UIImage!) {
        super.init(nibName: "MountainInfoVC", bundle: nil)
        mountainImage = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
