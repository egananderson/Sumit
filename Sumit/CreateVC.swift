//
//  CreateVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/11/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit

class CreateVC: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var usernameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        progUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Interface methods
    
    func progUI() {
        self.navigationController?.isNavigationBarHidden = true
        
        usernameTextField.delegate = self
        
        self.usernameTextField.becomeFirstResponder()
    }
    
    // MARK: Actions
    
    @IBAction func createPressed(_ sender: UIButton) {
        let userController = UserController.sharedInstance
        
        let username: String = usernameTextField.text!
        
        userController.createUser(username: username) { (success, error) in
            if !success {
                print("error createPressed")
            } else {
                DispatchQueue.main.async(execute: {
                    let mySumitVC = MySumitVC()
                    self.navigationController?.pushViewController(mySumitVC, animated: true)
                })
            }
        }
        
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        
        return true
    }
}
