//
//  mainController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-28.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.data)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        self.tabBarController!.tabBar.hidden = false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}