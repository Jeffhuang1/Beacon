//
//  messagingCell.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-10.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import UIKit

class messagingCell: UITableViewCell {

    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var lastMessage: UITextView!
    @IBOutlet weak var lastTime: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
