//
//  ViewController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-28.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var mSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.data)
        appDelegate.data = "Changed Test Data"
        print(appDelegate.data)
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
}