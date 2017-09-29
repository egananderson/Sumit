//
//  AppDelegate.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.isStatusBarHidden = true
        
        GMSServices.provideAPIKey("AIzaSyDSSMfuFX2ly2Qf1A0MaHawZ5Gc-L7w3Yw")
    
        let userController = UserController.sharedInstance
        //userController.logout()
 //       userController.loadUserLocal()
        
        let mapController = MapController.sharedInstance
 //
 //       mapController.selectUserDestinations { (success, error) in
 //           if !success {
 //               print("error app delegate")
 //           } else {
 //               DispatchQueue.main.async(execute: {
 //                   if userController.currentUser == nil {
 //                       rootVC = CreateVC()
 //                       self.window?.rootViewController = UINavigationController(rootViewController: rootVC!)
 //                   } else {
 //                       userController.currentUser = User(id: 7, user: "mtn_GOAT", score: 712)
 //                       mapController.mapVC?.addDestinations(destinations: mapController.destinations!)
        let tabBarController = TabBarController()
        let middleVC = mapController.mapVC!
        let middleImageBig = UIImage(named: "homebutton")
        let middleImage = imageWithImage(image: middleImageBig!, scaledToSize: CGSize(width: 40, height: 40))
        middleVC.tabBarItem = UITabBarItem(title: "", image: middleImage, selectedImage: middleImage)
        
        let rightVC = UINavigationController(rootViewController: MySumitVC())
        let rightImageBig = UIImage(named: "crown_black")
        let rightImage = imageWithImage(image: rightImageBig!, scaledToSize: CGSize(width: 40, height: 40))
        rightVC.tabBarItem = UITabBarItem(title: "", image: rightImage, selectedImage: rightImage)
        
        let leftVC = ChallengeVC()
        let leftImageBig = UIImage(named: "challengebutton")
        let leftImage = imageWithImage(image: leftImageBig!, scaledToSize: CGSize(width: 40, height: 40))
        leftVC.tabBarItem = UITabBarItem(title: "", image: leftImage, selectedImage: leftImage)
        
        tabBarController.viewControllers = [leftVC, middleVC, rightVC]
        tabBarController.selectedIndex = 1
        tabBarController.tabBar.barTintColor = UIColor.init(red: 206/255, green: 255/255, blue: 12/255, alpha: 1)
        tabBarController.tabBar.frame = CGRect(x: 0, y: self.window!.frame.height-72, width: self.window!.frame.width, height: 72)
        tabBarController.tabBar.items![0].image!.withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items?[1].image?.withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items?[2].image?.withRenderingMode(.alwaysOriginal)
        tabBarController.updateTabs()
        
        
        self.window?.rootViewController = tabBarController
 //                   }
 //               })
 //           }
 //       }

        return true
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 72 // adjust your size here
        return sizeThatFits
    }
}

