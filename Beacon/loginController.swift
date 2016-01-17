//
//  ViewController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-28.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var mSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        // Do any additional setup after loading the view, typically from a nib.
        if(FBSDKAccessToken.currentAccessToken() == nil){
        }
        else{
        }
        self.tabBarController!.tabBar.hidden = true
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem?.enabled = false
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController!.tabBar.hidden = true
        self.navigationItem.hidesBackButton = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func transitionState(sender: AnyObject) {
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "login"){
            (segue.destinationViewController as! chooseUniversityController).prevController = self.title!
            
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if(error == nil && FBSDKAccessToken.currentAccessToken() != nil){
            
            // Load user data from server
            appDelegate.loadServerData()
            
            // If user has data on server, i.e. has used app before, skip setup views and segue to My Beacon
            // Else segue to Choose University view to begin setup process
            if (appDelegate.selectedCourses != []) {
                self.performSegueWithIdentifier("existinguser", sender: self)
            } else {
                self.performSegueWithIdentifier("login", sender: self)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    }
}