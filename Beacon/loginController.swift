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
        if(FBSDKAccessToken.currentAccessToken() == nil){
            print("Not logged In")
        }
        else{
            print("Logged In")
        }
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func transitionState(sender: AnyObject) {
        if(mSwitch.on){
            performSegueWithIdentifier("autoLogin", sender: self)
        }
        else{
        performSegueWithIdentifier("login", sender: self)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "login"){
            NSLog("Switching State!")
            //var state:String
//            if(mSwitch.on){
//                state = "ON"
//            }
//            else{
//                state = "OFF"
//            }
//            (segue.destinationViewController as! chooseUniversityController).data = state
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if(error == nil){
            print("login complete")
            self.performSegueWithIdentifier("login", sender: self)
        } else {
            print(error)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out")
    }
}