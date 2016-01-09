//
//  AppDelegate.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-28.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//

import UIKit
import FBSDKCoreKit

let onConnectNotificationKey = "onConnect"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var data = "This is test data"
    
    var courses: [String] = []
    
    var current_course: String = ""
    var current_course_description: String = ""
    
    var first_run = true
    
    let socket = SocketIOClient(socketURL: "https://ece106.com", options: ["cookies": ["foo","jar"]])
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
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

    func connectSocketIO(){
        print("called connectSocketIO facebook Token = ", FBSDKAccessToken.currentAccessToken().tokenString)
        self.socket.connectParams = ["key": "bar"]
        self.socket.connect()
        self.addSocketHandlers()
    }
    
    func addSocketHandlers(){
        self.socket.onAny {print("Got event: \($0.event), with items: \($0.items)")}
        
        self.socket.on("connectionSuccessful") {data, ack in
            print("received connectionSuccessful")
            print(data)
            NSNotificationCenter.defaultCenter().postNotificationName(onConnectNotificationKey, object: self)
            return
        }
    }
}

