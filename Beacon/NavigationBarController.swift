//
//  NavigationBarController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-16.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import UIKit

class NavigationBarController: UINavigationController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor.init(red: 0.71, green: 0.529, blue: 1.0, alpha: 0.9)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        
    }

    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


