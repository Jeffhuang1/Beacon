//
//  myBeaconController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-09.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class myBeaconController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var scrolling: UIScrollView!
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var beaconButton: UIImageView!
    @IBOutlet weak var courseDescription: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var selectCourseButton: UIButton!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var keyboardHeight = CGFloat(1.0)
    var descriptionPlaceHolder = "PlaceHolder"
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.myBeaconRef = self
        
        appDelegate.connectSocketIO() // connects to socket io as a fallback for push notifications
        appDelegate.initLocationManager()
        appDelegate.loadServerData() // sets the user's name and loads their messages from server
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onConnectHandler", name: onConnectNotificationKey, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
        
        if (appDelegate.current_course_description != "") {
            courseDescription.text = appDelegate.current_course_description
        } else {
            print("empty course description", descriptionPlaceHolder)
            self.courseDescription.text = descriptionPlaceHolder
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
        
        courseDescription.delegate = self
        doneButton.tintColor = UIColor.clearColor()
        doneButton.enabled = false
        print("showing navbar")
        self.tabBarController!.tabBar.hidden = false;
        self.courseDescription.textContainer.lineFragmentPadding = 0;
        self.courseDescription.textContainerInset = UIEdgeInsetsMake(2,0,0,0);
        self.navigationItem.hidesBackButton = true
        if(FBSDKAccessToken.currentAccessToken() == nil){
            self.performSegueWithIdentifier("logout", sender: self)
        }
    }
    
    func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        self.keyboardHeight = keyboardRectangle.height / 2
        
        scrolling.contentSize.height += self.keyboardHeight
        print(self.keyboardHeight)
        scrolling.setContentOffset(CGPointMake(0, self.keyboardHeight), animated: true)
        doneButton.tintColor = nil
        doneButton.enabled = true
        
    }
    
    @IBAction func selectCourses(sender: AnyObject) {
        print("clicked courses")
        performSegueWithIdentifier("gotoCoursePicker", sender: self)
    }
    @IBAction func hideKeyboard(sender: AnyObject) {
        print("hiding keyboard")
        courseDescription.resignFirstResponder()
    }
    func keyboardWillHide() {
        scrolling.contentSize.height -= self.keyboardHeight
        doneButton.tintColor = UIColor.clearColor()
        doneButton.enabled = false
    }

    
    override func viewWillAppear(animated: Bool) {
        print("view will appear in beacon controller", appDelegate.current_course_description)
        courseDescription.text = appDelegate.current_course_description
        self.tabBarController!.tabBar.hidden = false
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("test")
        return true
    }
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = nil
    }
    func textViewDidChange(textView: UITextView) {
        appDelegate.current_course_description = textView.text
    }
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text != "" && textView.text != descriptionPlaceHolder){
            appDelegate.current_course_description = textView.text
        } else {
            textView.text = descriptionPlaceHolder
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onConnectHandler(){
        print("connect Handler in MyBeacon Controller")
    }
    
}
