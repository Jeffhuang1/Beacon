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
        
        
        let nib = UINib(nibName: "messagingCell", bundle: nil)
        messageTable.registerNib(nib, forCellReuseIdentifier: "messagingCell")
        self.messageTable.dataSource = self
        
        self.messageTable.rowHeight = CGFloat(70)
        
        //print(appDelegate.userMessages)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(0, appDelegate.userMessages.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:messagingCell = self.messageTable
            .dequeueReusableCellWithIdentifier("messagingCell") as! messagingCell!
        
        if appDelegate.userMessages.count > 0 {
            
            cell.senderName!.text = appDelegate.userMessages[indexPath.row].user
            cell.lastMessage!.text = appDelegate.userMessages[indexPath.row].messages[0].text
            let timeStamp = appDelegate.userMessages[indexPath.row].messages[0].senderId
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            cell.lastTime!.text = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: NSTimeInterval(Double(timeStamp)! / 1000)))
            
            
            let deleteButton = MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(), callback: {(sender: MGSwipeTableCell!) -> Bool in
                
                    self.appDelegate.deleteMessageThread((self.messageTable.indexPathForCell(sender)!).row)
                self.messageTable.deleteRowsAtIndexPaths([self.messageTable.indexPathForCell(sender)!], withRowAnimation: .Automatic)
            
                return true})
            
            cell.rightButtons = [deleteButton]
            
        }
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        self.messageTable.reloadData()
    }
}