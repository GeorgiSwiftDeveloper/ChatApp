//
//  LoginVC.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

   
    @IBOutlet weak var emailField: InsertextFild!
    
    @IBOutlet weak var passwordField: InsertextFild!
    
    @IBOutlet weak var logBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        logBtn.layer.cornerRadius = 15
        logBtn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        logBtn.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        logBtn.layer.borderWidth = 3
        
    }
    
    //MARK: Create account to the Firebase
    @IBAction func signInPressed(_ sender: UIButton) {
        if emailField.text != nil && passwordField.text != nil  {
            AuthService.instance.registerUser(email: self.emailField.text!, password: self.passwordField.text!) { (success, error) in
                if error != nil  {
                    print(error?.localizedDescription as Any)
                }else {
                    AuthService.instance.loginUser(email: self.emailField.text!, password: self.passwordField.text!, loginCreationComplete: { (success, error) in
                        self.dismiss(animated: true, completion: nil)
                        print("Successfuly registered user")
                    })
                }
            }

        }
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
        
        
        
}

