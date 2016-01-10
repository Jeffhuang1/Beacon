//
//  mainController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-28.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class MainController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.data)
    }
    override func viewDidAppear(animated: Bool) {
        print("view did appear")
        self.tabBarController!.tabBar.hidden = false;
        if(FBSDKAccessToken.currentAccessToken() == nil){
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
    }
    
    func onConnectHandler(){
        print("connect Handler in Main Controller")
    }
    
}