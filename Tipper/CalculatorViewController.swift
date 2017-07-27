//
//  ViewController.swift
//  Tipper
//
//  Created by Roman on 7/25/17.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // Represents the possible text fields a user can click
    enum Selections {
        case bill
        case tipPercent
        case split
    }
    
    // Stores the current text field that is first responder to the numeric keypad
    private var selectedField = Selections.bill { didSet { if selectedField != oldValue { fieldSwitched() } }}
    
    // Prepares UI based on the selected text field
    private func fieldSwitched() {
        switch selectedField {
        case .bill:
            billLabel.text!.isEmpty ? (deleteButton.isEnabled = false) : (deleteButton.isEnabled = true)
            animateFieldIndicator(to: billView)
        case .split:
            decimalButton.isEnabled = false
            splitLabel.text!.isEmpty ? (deleteButton.isEnabled = false) : (deleteButton.isEnabled = true)
            animateFieldIndicator(to: splitView)
        case .tipPercent:
            tipPercentLabel.text!.isEmpty ? (deleteButton.isEnabled = false) : (deleteButton.isEnabled = true)
            animateFieldIndicator(to: tipPercentView)
        }
    }
    
    // Animates the field indicator to the selected text field
    private func animateFieldIndicator(to destination: UIView) {
        let verticalDistance = (destination.frame.midY + 64) - fieldIndicator.frame.midY
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 2,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        self?.fieldIndicator.center = CGPoint(x: (self?.fieldIndicator.frame.midX)!, y: (self?.fieldIndicator.frame.midY)! + verticalDistance)})
    }
    
    /// -MARK: Outlets
    
    // Field Indicator is a white rectangle that highlights which field is the first responder to the numeric keypad
    @IBOutlet weak var fieldIndicator: UIView!
    
    
    // UIButtons
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    
    // UILabels
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var eachLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var eachDetailLabel: UILabel!
    
    /// MARK: Gesture Recognizing views
    
    @IBOutlet weak var billView: UIView! {
        didSet{
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(billViewTapped(byReactingTo:)))
            billView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    @IBOutlet weak var tipPercentView: UIView! {
        didSet{
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tipPercentViewTapped(byReactingTo:)))
            tipPercentView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    @IBOutlet weak var splitView: UIView!{
        didSet{
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(splitViewTapped(byReactingTo:)))
            splitView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    /// -MARK: Gesture Recognizer Functions
    
    func billViewTapped(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            selectedField = .bill
        }
    }
    
    func tipPercentViewTapped(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            selectedField = .tipPercent
        }
    }
    
    func splitViewTapped(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            selectedField = .split
        }
    }
    
    /// -MARK: Computed Properties
    /// The following properties convert the label between a string, for displaying, and a double for calculating new values
    
    var bill: Double {
        get {
            return Double(billLabel.text!) ?? 0
        } set {
            billLabel.text = newValue.cleanValue
        }
    }
    
    var tipPercent: Double {
        get {
            return Double(tipPercentLabel.text!) ?? 0
        } set {
            tipPercentLabel.text = newValue.cleanValue
        }
    }
    
    var tipAmount: Double {
        get {
            var tipText = tipAmountLabel.text
            tipText?.removeFirst()
            tipText?.removeFirst()
            return Double(tipText!) ?? 0
        } set {
            tipAmountLabel.text = String(format: "+$%.2f",newValue)
        }
    }
    
    var splitValue: Int {
        get {
            return Int(splitLabel.text!) ?? 1
        } set {
            splitLabel.text = String(newValue)
        }
    }
    
    /// -MARK: Actions
    
    @IBAction func digitPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        switch selectedField {
        case .bill:
            appendDigit(to: billLabel, with: digit)
        case .split:
            appendDigit(to: splitLabel, with: digit)
        case .tipPercent:
            appendDigit(to: tipPercentLabel, with: digit)
        }
        
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        switch selectedField {
        case .bill:
            removeDigit(from: billLabel)
        case .split:
            removeDigit(from: splitLabel)
        case .tipPercent:
            removeDigit(from: tipPercentLabel)
        }
    }
    
    // Appends the digit tapped on the keypad to the selected text field
    private func appendDigit(to label: UILabel, with digit: String){
        
        deleteButton.isEnabled = true
        
        if let text = label.text {
            label.text = text + digit
        } else {
            label.text = digit
        }
        
        // Check if there is a decimal in label
        if label.text?.range(of: ".") != nil {
            decimalButton.isEnabled = false
        } else {
            decimalButton.isEnabled = true
        }
        
        calculate()
    }
    
    // Deletes the last digit from the specified text field
    private func removeDigit(from label: UILabel) {
        if var text = label.text {
            text.remove(at: text.index(before: text.endIndex))
            if text.isEmpty {
                deleteButton.isEnabled = false
            }
            label.text = text
        }
        
        calculate()
    }
    
    // Calculates the values for the tip, total, and split total
    private func calculate() {
        tipAmount = bill * (tipPercent/100)
        totalLabel.text = String(format: "$%.2f", (bill + tipAmount))
        if splitValue <= 1 {
            eachLabel.text = ""
            eachDetailLabel.isHidden = true
        } else {
            eachLabel.text = String(format: "$%.2f", (bill + tipAmount) / Double(splitValue))
            eachDetailLabel.isHidden = false
        }
    }
    
    
    /// -MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make Navbar transparent by setting background image to an empty image
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        // Initialize Gradient Layer
        initGradientLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        colorGradient(with: Int(UserDefaults.standard.double(forKey: "theme")))
        
        // -TODO: Load defaults for tip and bill
        tipPercent = 15
    }
    
    /// -MARK: Gradient setup
    
    var gradientLayer: CAGradientLayer!
    
    // Initializes the gradient layer
    private func initGradientLayer () {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Set the colors of the gradient layer
    private func colorGradient(with defaultColor: Int) {
        gradientLayer.colors = Constants.gradients[defaultColor]
    }
    
}



extension Double {
    var cleanValue: String {
        return self .truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
