//
//  ItemTableViewCell.swift
//  VideoPlayer
//
//  Created by Thieu Mao on 7/21/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    func setupCell(_ text: String) {
        myLabel.text = text
    }
    
}
