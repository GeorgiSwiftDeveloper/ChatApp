//
//  FirstViewController.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class ChatVC: UIViewController {

    
    var messageArray : [Message] = [Message]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.reloadData()
       
        retriveMessages()
        
        
       
    }
    
    //MARK: Show Firebase information on the ChatVC
    func retriveMessages() {
        let messageDB = Database.database().reference().child("Message")
        messageDB.observe(.childAdded) { (snapshot) in
            let spanshotValue = snapshot.value as! Dictionary<String,String>
            let text = spanshotValue["MessageBody"]!
            let userSender = spanshotValue["Sender"]!
            
            let myMessage  = Message()
            myMessage.messagebody = text
            myMessage.sender = userSender
            
            self.messageArray.append(myMessage)
            
            self.configureTableView()
            self.myTableView.reloadData()
        }
    }
    
    func configureTableView() {
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 120.0
    }
    
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! GroupCell
        cell.userEmail.text = messageArray[indexPath.row].sender
        cell.userMessage.text = messageArray[indexPath.row].messagebody
        cell.userImage.image = UIImage(named: "defaultProfileImage")
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.size.width - 10)
      
        if cell.userEmail.text == Auth.auth().currentUser?.email {
            cell.userMessage.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            
        }else {
            cell.userMessage.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
