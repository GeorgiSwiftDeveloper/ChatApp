//
//  CreatePostVC.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/25/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var myTextView: UITextView!
    
    
    @IBOutlet weak var sendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextView.delegate = self
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        if myTextView.text != "" && myTextView.text != "Say something here..." {
            self.sendBtn.isEnabled = false
            print("Enter corect text!")
            let messageDB = Database.database().reference().child("Message")
            let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": myTextView.text!]
            messageDB.childByAutoId().setValue(messageDictionary){
                (error,reference) in
                if error != nil {
                    print(error!)
                }else {
                    print("message Save successfully!")
                    self.myTextView.text = ""
                    self.sendBtn.isEnabled = true
                }
                
            }
            
            
        }
    }
    
    @IBAction func goBackBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextView.text = ""
        
    }
}
