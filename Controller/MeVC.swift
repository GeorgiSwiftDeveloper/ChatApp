//
//  MeVC.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/25/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import  Firebase
class MeVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func signOutBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Log out ?", message: "Are u sure u wont to logout ?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Logout?", style: .destructive) { (myaction) in
            do{
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            }catch{
                print("Cant logout \(error.localizedDescription)")
            }
        }
        let actionNo = UIAlertAction(title: "NO", style: .default, handler: nil)
        alert.addAction(actionNo)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
