//
//  messagingCell.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-10.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import UIKit

class messagingCell: MGSwipeTableCell{

    @IBOutlet var senderName: UILabel!
    @IBOutlet var lastMessage: UILabel!
    @IBOutlet var lastTime: UILabel!


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
