//
//  AuthVC.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import  Firebase
class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func facebookSingInPressed(_ sender: UIButton) {
    }
    
    @IBAction func googleSignInPressed(_ sender: UIButton) {
    }
    
    @IBAction func sigInButtonPressed(_ sender: UIButton) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(loginVC!, animated: true, completion:   nil)
    }
}
