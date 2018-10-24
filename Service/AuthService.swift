//
//  AuthService.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/24/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import Foundation
import Firebase

class AuthService: UIViewController {
    static let instance = AuthService()
    
    func registerUser(email: String, password: String, userCreationComplete: @escaping (_ status : Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                userCreationComplete(false, error)
                return
            }
            userCreationComplete(true, nil)
        }
    }
    
    
    
    func loginUser(email: String, password: String, loginCreationComplete: @escaping (_ status : Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginCreationComplete(false, error)
                return
            }
           loginCreationComplete(true, nil)
        }
    }
}
