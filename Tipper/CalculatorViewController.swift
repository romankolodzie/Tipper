//
//  ViewController.swift
//  Tipper
//
//  Created by Roman on 7/25/17.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tipControl.selectedSegmentIndex = Int(defaults.double(forKey: "DefaultTipValue"))
        if billTextField.text != "" {
            calculateTip(self)
        }
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let tipAmounts = [0.18, 0.2, 0.25]
        
        guard let billAmount = Double(billTextField.text!) else {
            totalAmountLabel.text = "Error reading bill amount. Retry"
            return
        }
        
        let tip  = billAmount * tipAmounts[tipControl.selectedSegmentIndex]
        let total = billAmount + tip
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalAmountLabel.text = String(format: "$%.2f", total)
    }
    
    
}

