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
    
    
    
    
    var choosenArray = [String]()
    
    var emailArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        emailTextFild.delegate = self
        
        emailTextFild.addTarget(self, action: #selector(textFieldDidiChange), for: .editingChanged)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
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
        if titleTextFild.text != "" && descriptionTextFild.text != "" {
            getIds(forUsername: choosenArray) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                self.createGroup(withTitle: self.titleTextFild.text!, andDescriptionn: self.descriptionTextFild.text!, forUserId: userIds, handler: { (group) in
                    if group{
                        self.dismiss(animated: true, completion: nil)
                    }else {
                        print("could not be created")
                    }
                })
            }
        }
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
    
    func getIds(forUsername username: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        Database.database().reference(withPath: "Message").observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                 let email = user.childSnapshot(forPath: "Sender").value as! String
                if username.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }


    func createGroup(withTitle title: String, andDescriptionn description: String, forUserId uId: [String], handler: @escaping (_ groupCreated: Bool) ->()) {
        Database.database().reference(withPath: "Group").childByAutoId().updateChildValues(["title": title, "description": description, "members": uId])
        handler(true)
    }
}

extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return emailArray.count
//        
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(porofileImage: profileImage!, email: self.emailArray[indexPath.row], isSelected: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else  {return}
        if !choosenArray.contains(cell.emailLbl.text!) {
            choosenArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = choosenArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }else {
            choosenArray = choosenArray.filter({$0 != cell.emailLbl.text!})
            if choosenArray.count >= 1 {
                 groupMemberLbl.text = choosenArray.joined(separator: ", ")
            }else {
                groupMemberLbl.text = "Add people to your group"
                doneBtn.isHidden = true
            }
        }
        
    }
    
    
}

