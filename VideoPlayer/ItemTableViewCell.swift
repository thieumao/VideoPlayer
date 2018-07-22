//
//  ItemTableViewCell.swift
//  VideoPlayer
//
//  Created by Thieu Mao on 7/21/18.
//  Copyright © 2018 Thieu Mao. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class ItemTableViewCell: MGSwipeTableCell {
    
    @IBOutlet weak var myLabel: UILabel!
    
    func setupCell(_ playlist: Playlist) {
        // configure left buttons
        leftButtons = [MGSwipeButton(title: "Add",backgroundColor: .green)]
        leftSwipeSettings.transition = .rotate3D
        
        // configure right buttons
        rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red)]
        rightSwipeSettings.transition = .rotate3D

        // set text
        myLabel.text = playlist.title
    }
    
}
