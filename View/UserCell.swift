//
//  UserCell.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/27/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

  
    
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var emailLbl: UILabel!
    
    
    @IBOutlet weak var checkLbl: UIImageView!
    
    var showing =  false
    
    func configureCell(porofileImage image: UIImage, email: String, isSelected: Bool) {
        self.imageUser.image = image
        self.emailLbl.text = email
        if isSelected{
            self.checkLbl.isHidden = false
        }else {
            self.checkLbl.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            if showing == false {
                checkLbl.isHidden = false
                showing = true
            }else {
                checkLbl.isHidden = true
                showing = false
            }
        }
       
    }

}
