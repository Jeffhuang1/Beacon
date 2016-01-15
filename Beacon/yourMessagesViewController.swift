//
//  yourMessagesViewController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-10.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class YourMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var messageTable: UITableView!
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageTable.registerClass(messagingCell.self, forCellReuseIdentifier: "cell")
        self.messageTable.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(1, appDelegate.userMessages.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:messagingCell = self.messageTable
            .dequeueReusableCellWithIdentifier("cell") as! messagingCell!
        if appDelegate.userMessages.count > 0 {
            let stringA = appDelegate.userMessages[indexPath.row].user
            cell.textLabel!.text = stringA
        }
        else {
            cell.textLabel!.text = "No messages!?!"
        }
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        self.messageTable.reloadData()
    }
}