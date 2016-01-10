//
//  beaconSearchController.swift
//  Beacon
//
//  Created by Emily Semple on 2016-01-10.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import GoogleMaps
import UIKit

class beaconSearchController: UIViewController {
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        print("View will appear")
    }
    
    
    override func viewDidLoad() {
        print("begin viewdidload")
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6)
        let mapview = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapview.myLocationEnabled = true
        self.view = mapview
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapview
        print("Viewdidload done running")
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
    }
    
    
    
}