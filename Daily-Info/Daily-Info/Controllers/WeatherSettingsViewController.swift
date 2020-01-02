//
//  WeatherSettingsViewController.swift
//  Daily-Info
//
//  Created by Ruben  De Freyne on 30/12/2019.
//  Copyright © 2019 Ruben  De Freyne. All rights reserved.
//

import UIKit

class WeatherSettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet var control: UISegmentedControl!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var textField: UITextField!
    
    var units = "metric"
    var postalCode = 9000
    
    func updateSaveButtonState(){
        let text = textField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        checkForWeatherSettings()
        textField.text = String(postalCode)
        if units == "metric"{
            control.selectedSegmentIndex = 0
        } else {
            control.selectedSegmentIndex = 1
        }
        
        updateSaveButtonState()
    }
    
    func setWeatherSettings(){
        defaults.set(units, forKey: "units")
        defaults.set(postalCode, forKey: "postalCode")
    }
    
    func checkForWeatherSettings(){
        units = defaults.string(forKey:"units") ?? "metric"
        let usersPostalCode = defaults.integer(forKey:"postalCode")
        if usersPostalCode != 0 {
            postalCode = usersPostalCode
        }
    }
    
    @IBAction func unitsValueChanged(_ sender: UISegmentedControl) {
        if units == "metric" {
            units = "imperial"
        } else {
            units = "metric"
        }
    }
    @IBAction func onResign(_ sender: Any) {
        textField.resignFirstResponder()
    }
    @IBAction func editingChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
            setWeatherSettings()
    }
}

