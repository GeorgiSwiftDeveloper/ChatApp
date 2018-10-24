//
//  ShadowView.swift
//  ChatApp
//
//  Created by Georgi Malkhasyan on 10/23/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.80
        self.layer.shadowRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }

}
