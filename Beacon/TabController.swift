//
//  TabController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-16.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class TabController: UITabBarController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print(item.title == "My Beacon")
        print("Title is:", item.title)
        if(item.title == "My Beacon"){
            print("Switched to my beacon")
            if(FBSDKAccessToken.currentAccessToken() == nil){
                appDelegate.myBeaconRef!.performSegueWithIdentifier("logout", sender: appDelegate.myBeaconRef)
                self.tabBar.hidden = false;
            }
        }
    }
}