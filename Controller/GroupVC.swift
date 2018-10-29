//
//  SecondViewController.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import  Firebase
class GroupVC: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    
    var groupsArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self  
        myTableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        Database.database().reference(withPath: "Group").observe(.value) { (snapshot) in
            getAllGroups(handler: { (returnGroups) in
                self.groupsArray = returnGroups
                self.myTableView.reloadData()
            })
        }
    }
    
}


//MARK: Pull all groups from Firebase, create array of group

func getAllGroups(handler: @escaping (_ gropsArray: [Group]) -> ()) {
    var groupsArray = [Group]()
    Database.database().reference(withPath: "Group").observeSingleEvent(of: .value) { (groupSnapshot) in
        guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
        for group in groupSnapshot {
            let memberArray = group.childSnapshot(forPath: "members").value as! [String]
            if memberArray.contains((Auth.auth().currentUser?.uid)!){
                let title = group.childSnapshot(forPath: "title").value as! String
                let description = group.childSnapshot(forPath: "description").value as! String
                
                let group = Group(title: title, description: description, key: group.key, members: memberArray, memberCount: memberArray.count)
                groupsArray.append(group)
            }
        }
        handler(groupsArray)
    }
}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "globalCell", for: indexPath) as? GlobalCell
        let grops = groupsArray[indexPath.row]
        cell!.categryCell(title: grops.groupTitle , description:grops.groupDesc, members: grops.memberCount)
        return cell!
    }
    
    
}
