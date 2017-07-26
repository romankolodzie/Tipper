//
//  SettingsViewController.swift
//  Tipper
//
//  Created by Roman on 7/25/17.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    let tipAmounts = [0.18, 0.2, 0.25]
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultTipControl.selectedSegmentIndex = Int(defaults.double(forKey: "DefaultTipValue"))
    }
    
    @IBAction func defaultTipChanged(_ sender: Any) {
        defaults.set(defaultTipControl.selectedSegmentIndex, forKey: "DefaultTipValue")
        print("default set to \(defaults.double(forKey: "DefaultTipValue"))")
    }
    
}
