//
//  CreateGroupVC.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/26/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import  Firebase
class CreateGroupVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextFild: InsertextFild!
    
    @IBOutlet weak var descriptionTextFild: InsertextFild!
   
    @IBOutlet weak var emailTextFild: InsertextFild!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    var emailArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        emailTextFild.delegate = self
        
        emailTextFild.addTarget(self, action: #selector(textFieldDidiChange), for: .editingChanged)
    }
    
    
    @objc func textFieldDidiChange() {
        if emailTextFild.text == "" {
            emailArray = []
            myTableView.reloadData()
        }else {
            getEmail(forSerchQuery: emailTextFild.text!) { (returnEmailArray) in
                self.emailArray = returnEmailArray
                self.myTableView.reloadData()
            }
        }
    }

  
    @IBAction func doneBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func getEmail(forSerchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        Database.database().reference(withPath: "Message").observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "Sender").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
        
        
    }


}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(porofileImage: profileImage!, email: self.emailArray[indexPath.row], isSelected: true)
        return cell
    }
    
    
}

