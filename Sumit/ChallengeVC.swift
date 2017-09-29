//
//  ChallengeVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 3/29/17.
//  Copyright © 2017 via cole. All rights reserved.
//

import UIKit

class ChallengeVC: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: Properties
    fileprivate var imagePageVC: UIPageViewController?
    
    fileprivate var pages: [UIViewController]?
    var index: Int?
    
    @IBOutlet weak var frame: UIView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.imagePageVC?.dataSource = self
        
        progUI()
        

    }
    
    // MARK: Interface
    func progUI() {
        headerHeight.constant = CGFloat(UIScreen.main.bounds.height / 3.8)
        
    }

    override func viewDidLayoutSubviews() {
        
        let width = self.frame.frame.width
        let height = self.frame.frame.height
        
        self.imagePageVC?.view.frame = CGRect(x:0, y: 0, width: width, height: height)
        self.frame.backgroundColor = UIColor.clear
        let challenges = ["challenge.png","sponsors.png"]
            
        var i = 0
            
        self.pages = [UIViewController]()
        for imageName in challenges {
            let challengeVC = ChallengImageVC()
            challengeVC.imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            //challengeVC.imageView.frame = (self.imagePageVC?.view.frame)!
            challengeVC.imageView.image = UIImage(named: imageName)
            challengeVC.index = i
            self.pages?.append(challengeVC)
            i += 1
        }
        
        self.imagePageVC?.setViewControllers([self.pages![0]], direction: .forward, animated: true, completion: nil)
        self.frame.addSubview((self.imagePageVC?.view)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UIPageViewControllerDataSource methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ChallengImageVC
        
        let index = vc.index
        let count = self.pages?.count
        
        if index == 1 {
            
            return nil
            
        } else {
            
            return self.pages?[1]
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ChallengImageVC
        
        let index = vc.index
        let count = self.pages?.count
        
        if index == 0 {
            
            return nil
            
        } else {
            
            return self.pages?[0]
            
        }
    }


}
