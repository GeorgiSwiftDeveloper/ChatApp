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
        sendBtn.bindToKeyboard()
        
        
        sendBtn.layer.cornerRadius = 15
        sendBtn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        sendBtn.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        sendBtn.layer.borderWidth = 3
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailLbl.text = Auth.auth().currentUser?.email
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
