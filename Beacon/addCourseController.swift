//
//  addCourseController.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-29.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//


import UIKit

class AddCourseController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var courseSelection: UITextField!
    
    var data = [
        "Select a Course",
        "Math 138",
        "Mech 227",
        "ECE 403",
        "ENGL 109"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        courseSelection.inputView = picker
        courseSelection.becomeFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(data[row] != "Select a Course"){
            courseSelection.text = data[row]
            addButton.enabled = true
        } else {
            addButton.enabled = false
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row];
    }
    
    
    @IBAction func addAndExit(sender: AnyObject) {
        appDelegate.selectedCourses.append((courseSelection.text)!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}