//
//  LoginVC.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

   
    @IBOutlet weak var emailField: InsertextFild!
    
    @IBOutlet weak var passwordField: InsertextFild!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(email: emailField.text!, password: passwordField.text!) { (success, error) in
                if success  {
                    self.dismiss(animated: true, completion: nil)
                    print("Successfuly registered user")
                    
                }else {
                    print(String(describing: error?.localizedDescription))
                    let alert = UIAlertController(title: "Enter Corect settings", message: "and try again", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        self.emailField.text = ""
                        self.passwordField.text  = ""
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                
                AuthService.instance.registerUser(email: self.emailField.text!, password: self.passwordField.text!, userCreationComplete: { (success, error) in
                    if success {
                        AuthService.instance.loginUser(email: self.emailField.text!, password: self.passwordField.text!, loginCreationComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                        })
                    }else {
                        print(String(describing: error?.localizedDescription))
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
