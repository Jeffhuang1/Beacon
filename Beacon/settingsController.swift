//
//  settingsController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2016-01-09.
//  Copyright © 2016 Jeffrey Huang. All rights reserved.
//

import FBSDKLoginKit
import UIKit

class SettingsController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet var settingsTable: UITableView!
    var data = [
        "Select a University",
        "University of Waterloo",
        "Laurier University",
        "Foo University"
    ]
    var courses = [
        "Select a Course",
        "Math 138",
        "Mech 227",
        "ECE 403",
        "ENGL 109"
    ]
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let universityPicker = UIPickerView()
    let coursesPicker = UIPickerView()
    let toolBar = UIToolbar()
    var doneButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    let universityTextField = UITextField()
    let addCoursesTextField = UITextField()
    let locationSwitch = UISwitch()
    var currentPicker = 0
    var currentCourseValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initToolbar()
        universityPicker.dataSource = self
        universityPicker.delegate = self
        universityPicker.tag = 0
        coursesPicker.dataSource = self
        coursesPicker.delegate = self
        coursesPicker.tag = 1
        initTextField()
        locationSwitch.addTarget(self, action: "toggledSwitch", forControlEvents: UIControlEvents.ValueChanged)
        settingsTable.delegate = self
        //editCourses.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        settingsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        settingsTable.dataSource = self
        print(self.title)
        
    }
    override func viewDidAppear(animated: Bool) {
        // Do nothing
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("index path row", indexPath.row)
        print("number of rows in section", self.settingsTable.numberOfRowsInSection(2))
        if (indexPath.section == 1 && indexPath.row == 0){
            print("selected change University")
            doneButton.enabled = false
            self.currentPicker = 0
            universityTextField.becomeFirstResponder()
        }
        else if (indexPath.section == 3 && indexPath.row == 0) {
            FBSDKAccessToken.setCurrentAccessToken(nil)
            self.tabBarController!.selectedIndex = 0
        } else if(indexPath.section == 2 && indexPath.row == self.settingsTable.numberOfRowsInSection(2) - 1){
            print("clicked add courses cell")
            doneButton.enabled = false
            self.currentPicker = 1
            addCoursesTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "editUniversity"){
            (segue.destinationViewController as! chooseUniversityController).prevController = self.title!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("section", section)
        if(section == 2){
            return appDelegate.selectedCourses.count
        } else{
            return 1
        }
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "My Beacon"
        } else if(section == 1){
            return "Change University"
        } else if(section == 2){
            return "Your Courses"
        } else {
            return "Facebook"
        }
    }
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if(section == 0){
            return "Automatically disables your beacon when your device moves away from the location it was set"
        } else if(section == 3){
            return "This changes the courses you see while searching for other beacons"
        } else {
            return super.tableView(settingsTable, titleForFooterInSection: section)
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.settingsTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        if (indexPath.section == 2){
            print("indexpath row", indexPath.row)
            if(appDelegate.selectedCourses[indexPath.row] == "Add Courses"){
                cell.accessoryView = addCoursesTextField
            }
            cell.textLabel!.text = appDelegate.selectedCourses[indexPath.row]
        } else if(indexPath.section == 1){
            cell.accessoryView = universityTextField
            print("appDelegateCurrentUniversity", appDelegate.currentUniversity)
            cell.textLabel!.text = appDelegate.currentUniversity
        } else if(indexPath.section == 0){
            cell.textLabel!.text = "Location Auto-Disable"
            //cell.accessoryView = locationSwitch
        } else {
            cell.textLabel!.text = "Log out of Facebook"
        }
        return cell
    }
    func initToolbar(){
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.sizeToFit()
        cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Bordered, target: self, action: "cancelPicker")
        doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker")
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        toolBar.setItems([ cancelButton, flexible, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
    }
    func initTextField(){
        universityTextField.tintColor = UIColor.clearColor()
        universityTextField.inputView = universityPicker
        universityTextField.inputAccessoryView = toolBar
        addCoursesTextField.tintColor = UIColor.clearColor()
        addCoursesTextField.inputView = coursesPicker
        addCoursesTextField.inputAccessoryView = toolBar
    }
    func cancelPicker(){
        universityTextField.resignFirstResponder()
        addCoursesTextField.resignFirstResponder()
    }
    func donePicker(){
        print("called")
        if(currentPicker == 0){
            universityTextField.resignFirstResponder()
        } else {
            addCoursesTextField.resignFirstResponder()
            if(appDelegate.selectedCourses.count > 1){
                appDelegate.selectedCourses.popLast()
            }
            appDelegate.selectedCourses.append(currentCourseValue)
            appDelegate.selectedCourses.append("Add Course")
        }
        self.tableView.reloadData()
    }
    
    func toggledSwitch(){
        print(locationSwitch.on)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 0){
            return data.count
        } else {
            return courses.count
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0){
            if(data[row] != "Select a University"){
                print("enabling")
                appDelegate.currentUniversity = data[row]
                doneButton.enabled = true
            } else {
                print("disabling")
                doneButton.enabled = false
            }
        } else {
            if(courses[row] != "Select a Course"){
                currentCourseValue = courses[row]
                doneButton.enabled = true
            } else {
                doneButton.enabled = false
                                print("disabling")
            }
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 0){
            return data[row]
        } else {
            return courses[row]
        }
    }
    
    
}