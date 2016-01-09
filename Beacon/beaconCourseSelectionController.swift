//
//  beaconCourseSelectionController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-09.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import UIKit

class beaconCourseSelectionController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet weak var courseTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        courseTable.delegate = self
        
        self.courseTable.becomeFirstResponder()
        
        self.courseTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.courseTable.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appDelegate.courses.count == 0 {
            return 1
        }
        else {
            return appDelegate.courses.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.courseTable
            .dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if appDelegate.courses.count > 0 {
            
            cell.textLabel!.text = appDelegate.courses[indexPath.row]
        }
        else {
            cell.textLabel!.text = "No courses available :("
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if appDelegate.courses.count != 0 && appDelegate.current_course != appDelegate.courses[indexPath.row]{
            appDelegate.current_course = appDelegate.courses[indexPath.row]
            appDelegate.current_course_description = ""
        }
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    override func viewDidAppear(animated: Bool) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
