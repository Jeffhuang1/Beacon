//
//  messagesClass.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-10.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import Foundation

class UserMessages {
    let user: String
    var messages = [JSQMessage]()
    
    init(user fromUser: String){
        user = fromUser
    }
}