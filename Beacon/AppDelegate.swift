//
//  AppDelegate.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-28.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleMaps
import CoreLocation

let onConnectNotificationKey = "onConnect"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?
    var data = "This is test data"
    var userMessages: [UserMessages] = []
    var selectedCourses: [String] = ["Cats 101"]
    var currentUniversity = "University of Waterloo"
    var current_course: String = ""
    var current_course_description: String = ""
    var currentLocation: CLLocation?
    var fbId: String?
    var fbName: String?
    
    var myBeaconRef: myBeaconController?
    
    let socket = SocketIOClient(socketURL: "https://ece106.com", options: ["cookies": ["foo","jar"]])
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey("AIzaSyByiYZKWwl3XbFfUR-eaiC2CC65gWbyWOk")
        if #available(iOS 8.0, *) {
            
            // register iOS 8
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound, .Badge], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
        } else {
            
            // register iOS 7 and below
            UIApplication.sharedApplication().registerForRemoteNotificationTypes([.Alert, .Sound, .Badge])
        }
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Failed to get Token: Error = ", error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        // display the userInfo
        if let notification = userInfo["aps"] as? NSDictionary,
            let alert = notification["alert"] as? String {
        }
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    //Mark: LocationManager Delegate
    func initLocationManager(){
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager!.requestAlwaysAuthorization()
        }
        locationManager!.startUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[locations.count - 1]
        self.sendLocation(currentLocation!)

    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func getMajorSystemVersion() -> String {
        return UIDevice.currentDevice().systemVersion
    }
    
    func httpPost(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, data: NSDictionary??) -> ()){
        let request = NSMutableURLRequest(URL: NSURL(string: "https://ece106.com/api/" + url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(FBSDKAccessToken.currentAccessToken().tokenString, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (data != nil){
                let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                if (json != nil) {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    postCompleted(succeeded: true, data: json)
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    postCompleted(succeeded: true, data: nil)
                }
            } else {
                postCompleted(succeeded: false, data: nil)
            }
        })
        
        task.resume()
    }
    
    func httpGet(url : String, getCompleted : (succeeded: Bool, data: NSDictionary??) -> ()){
        let request = NSMutableURLRequest(URL: NSURL(string: "https://ece106.com/api/" + url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue(FBSDKAccessToken.currentAccessToken().tokenString, forHTTPHeaderField: "Authorization")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if (data != nil){
                let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                if (json != nil) {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    getCompleted(succeeded: true, data: json)
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    getCompleted(succeeded: false, data: nil)
                }
            } else {
                getCompleted(succeeded: false, data: nil)
            }
        })
        
        task.resume()
    }
    func loadServerData(){
        if(FBSDKAccessToken.currentAccessToken() != nil){
            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"id,name"]).startWithCompletionHandler({ (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
                if(error != nil){
                }else{
                    self.fbId = String(result["id"])
                    self.fbName = String(result["name"])
                }
            })
            self.getMessages()
        }
        
    }
    
    func sendMessage(message: String, id: String) {
        self.httpPost(["message": message, "id": id], url: "send", postCompleted: {
            (succeeded, data) -> Void in
        })
    }
    
    func sendLocation(location: CLLocation) {
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        self.httpPost([ "latitude": latitude, "longitude": longitude], url: "mylocation", postCompleted: {
            (succeeded, data) -> Void in
        })
    }
    
    func connectSocketIO(){
        //print("called connectSocketIO facebook Token = ", FBSDKAccessToken.currentAccessToken().tokenString)
        self.socket.connectParams = ["key": "bar"]
        self.socket.connect()
        self.addSocketHandlers()
    }
    
    func addSocketHandlers(){
        //self.socket.onAny {print("Got event: \($0.event), with items: \($0.items)")}
        
        /*self.socket.on("connectionSuccessful") {data, ack in
            print("received connectionSuccessful")
            print(data)
            NSNotificationCenter.defaultCenter().postNotificationName(onConnectNotificationKey, object: self)
            return
        }*/
    }
    
    func getMessages() {
        self.httpGet("mymessages", getCompleted: {
            (succeeded, data) -> Void in
            //print("data: ", data)
            //print("got server response", data)
            if(data != nil){
                let messages = data!!["messages"]
                for(var i = 0; i < messages!.count; ++i){
                    let messageHistory = messages![i]!["message"]
                    self.userMessages.append(UserMessages(user: String(messageHistory!![0]!["senderName"]!!)))
                    for(var j = 0; j < messageHistory!!.count; j++){
                        //let senderId = String(messageHistory!![i]!["sender"]!!)
                        let sender = String(messageHistory!![j]!["senderName"]!!)
                        let messageContent = String(messageHistory!![j]!["message"]!!)
                        let messageTime = String(messageHistory!![j]!["timeStamp"]!!)
                        self.userMessages[i].messages.append(JSQMessage(senderId: messageTime, displayName: sender, text: messageContent))
                }
            }
            }
        })

    }
    
    func deleteMessageThread(index: Int) {
        self.userMessages.removeAtIndex(index)
    }
}

