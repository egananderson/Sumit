//
//  CameraVC.swift
//  Sumit
//
//  Created by Cole Wilkes on 11/12/16.
//  Copyright © 2016 via cole. All rights reserved.
//

import UIKit

class CameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    var imagePicker: UIImagePickerController?
    @IBOutlet var textField: UITextView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.isEditable = false
        textField.text = ""
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont(name: (textField.font?.fontName)!, size: 30)
        
        continueButton.isHidden = true
        
        spinner.startAnimating()
        
        progUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Interface methods
    
    func progUI() {
        self.imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .camera
        imagePicker?.allowsEditing = true
        self.navigationController?.isNavigationBarHidden = true
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    // MARK: Image picker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //spinny wheel
        spinner.isHidden = false
        spinner.startAnimating()
        let userController = UserController.sharedInstance
        userController.uploadPhoto(image) { (success, error) in
            if !success {
                print("error photo upload")
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                DispatchQueue.main.async(execute: {
                    self.spinner.isHidden = true
                    self.textField.text = "\(userController.recentSumit!.score) points have been added to your sum"
                    self.textField.isHidden = false
                    self.continueButton.isHidden = false
                })
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func photoSuccess() {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
