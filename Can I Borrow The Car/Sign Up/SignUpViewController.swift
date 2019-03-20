//
//  SignUpViewController.swift
//  Can I Borrow The Car
//
//  Created by Kristoffer Knape on 2019-03-19.
//  Copyright © 2019 Kristoffer Knape. All rights reserved.
//

import UIKit
import ProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: AuthPlaceholder!
    @IBOutlet weak var emailLabel: AuthPlaceholder!
    @IBOutlet weak var passwordLabel: AuthPlaceholder!
    @IBOutlet weak var rePasswordLabel: AuthPlaceholder!
    
    var selectImageFromPicker: UIImage?
    var isPicturePicked = false
    var samePassword = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeProfileImageOnClick()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        completeUser()
    }
    
    private func completeUser() {
        checkTextFields {
            view.endEditing(true)
            ProgressHUD.show()
            setValuesToUser {
                ProgressHUD.showSuccess()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func checkTextFields(completion: () -> Void) {
        if labelsNotEmpty() == true {
            completion()
        }
    }
    
    private func setValuesToUser(completion: @escaping () -> Void) {
        if let profileImg = self.selectImageFromPicker {
            if let imageData = profileImg.jpegData(compressionQuality: 0.1) {
                AuthService.signUp(username: self.userNameLabel.text!, email: self.emailLabel.text!, password: self.passwordLabel.text!, imageData: imageData, signedIn: completion) { (error) in
                    ProgressHUD.showError(error)
                }
            }
        }
    }
    
    

}
