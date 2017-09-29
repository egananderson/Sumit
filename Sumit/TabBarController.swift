//
//  TabBarController.swift
//  Sumit
//
//  Created by Egan Anderson on 3/29/17.
//  Copyright © 2017 via cole. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateTabs() {
        // set selected and unselected icons
        let item0: UITabBarItem = self.tabBar.items![0]
        let item1: UITabBarItem = self.tabBar.items![1]
        let item2: UITabBarItem = self.tabBar.items![2]
        
        // this way, the icon gets rendered as it is (thus, it needs to be green in this example)
        var image0 = UIImage(named: "challengebutton")
        image0 = imageWithImage(image: image0!, scaledToSize: CGSize(width: 40, height: 24))
        item0.imageInsets = UIEdgeInsetsMake(item0.imageInsets.top+5, item0.imageInsets.left, item0.imageInsets.bottom-5, item0.imageInsets.right)
        item0.image = image0?.withRenderingMode(.alwaysOriginal)
 
        var image1 = UIImage(named: "homebutton")
        image1 = imageWithImage(image: image1!, scaledToSize: CGSize(width: 52, height: 52))
        item1.imageInsets = UIEdgeInsetsMake(item0.imageInsets.top+1, item0.imageInsets.left, item0.imageInsets.bottom-1, item0.imageInsets.right)
        item1.image = image1!.withRenderingMode(.alwaysOriginal)
        
        var image2 = UIImage(named: "crown_black")
        image2 = imageWithImage(image: image2!, scaledToSize: CGSize(width: 30, height: 23))
        item2.imageInsets = UIEdgeInsetsMake(item0.imageInsets.top+1, item0.imageInsets.left, item0.imageInsets.bottom-1, item0.imageInsets.right)
        item2.image = image2!.withRenderingMode(.alwaysOriginal)
        
        
        // this icon is used for selected tab and it will get tinted as defined in self.tabBar.tintColor
        item0.selectedImage = image0!.withRenderingMode(.alwaysOriginal)
        item1.selectedImage = image1!.withRenderingMode(.alwaysOriginal)
        item2.selectedImage = image2!.withRenderingMode(.alwaysOriginal)

    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
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
