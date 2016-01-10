//
//  settingsController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-09.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import FBSDKLoginKit
import UIKit

class SettingsController: UITableViewController {
    
    @IBOutlet var settingsTable: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTable.delegate = self
        print(self.title)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 2 && indexPath.row == 0) {
            FBSDKAccessToken.setCurrentAccessToken(nil)
            self.tabBarController!.selectedIndex = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "editUniversity"){
            (segue.destinationViewController as! chooseUniversityController).prevController = self.title!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}