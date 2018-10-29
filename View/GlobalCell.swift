//
//  GlobalCell.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/29/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class GlobalCell: UITableViewCell {

    
    @IBOutlet weak var groupLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var membersLbl: UILabel!
    
    
    
    func categryCell(title: String, description: String, members: Int) {
        self.groupLbl.text = title
        self.descriptionLbl.text = description
        self.membersLbl.text = "\(members)"
    }

   

}
