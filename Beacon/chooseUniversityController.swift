//
//  chooseUniversity.swift
//  Beacon
//
//  Created by Jeffrey Huang on 2015-12-28.
//  Copyright © 2015 Jeffrey Huang. All rights reserved.
//

import UIKit

class chooseUniversityController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var chooseUniversity: UITextField!
    var data = [
            "Select a University",
            "University of Waterloo",
            "Laurier University",
            "Foo University"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        chooseUniversity.inputView = picker
        chooseUniversity.becomeFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(data[row] != "Select a University"){
            chooseUniversity.text = data[row]
            nextButton.enabled = true
        } else {
            nextButton.enabled = false
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row];
    }
    
    override func viewDidAppear(animated: Bool) {
        if !(appDelegate.first_run) {
            nextButton.tintColor = UIColor.clearColor()
            nextButton.enabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

