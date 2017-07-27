//
//  SettingsViewController.swift
//  Tipper
//
//  Created by Roman on 7/26/17.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    
    // Shorthand for default notation
    let defaults = UserDefaults.standard

    // -MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initGradient()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientColor()
    }

    @IBAction func themeChanged(_ sender: UIButton) {
        let themeID = Int(sender.currentTitle!)!
        defaults.set(themeID, forKey: "theme")
        setGradientColor()
    }
    
    private func setGradientColor() {
        gradientLayer.colors = Constants.gradients[Int(defaults.double(forKey: "theme"))]
    }
    
    private func initGradient() {
        gradientLayer = CAGradientLayer()
        let navbar = self.navigationController?.navigationBar
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: UIApplication.shared.statusBarFrame.height + (navbar?.frame.height)!)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
