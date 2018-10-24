//
//  AuthVC.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
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
