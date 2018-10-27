//
//  DataService.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = Database.database().reference()


class DataService {
    static let instance = DataService()
    
//
//    private var _REF_BASE = DB_BASE
//    private var _REF_USERS = DB_BASE.child("Sender")
////    private var _REF_GROUPS = DB_BASE.child("gropue")
////    private var _REF_FEED = DB_BASE.child("feed")
//
//
//    var REF_BASE: DatabaseReference {
//        return _REF_BASE
//    }
//    var REF_USERS: DatabaseReference {
//        return _REF_USERS
//    }
////    var REF_GROUPS: DatabaseReference {
////        return _REF_GROUPS
////    }
////    var REF_FEED: DatabaseReference {
////        return _REF_FEED
////    }
////
//
//    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
//        REF_USERS.child(uid).updateChildValues(userData)
//    }
//    
    
    
//    
//    func getEmail(forSerchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
//        var emailArray = [String]()
//        REF_USERS.observe(.value) { (userSnapshot) in
//            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
//
//            for user in userSnapshot {
//                let email = user.childSnapshot(forPath: "Sender").value as! String
//                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
//                    emailArray.append(email)
//                }
//            }
//            handler(emailArray)
//        }
//        
//
//    }
}


