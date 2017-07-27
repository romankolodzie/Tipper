//
//  Constants.swift
//  Tipper
//
//  Created by Roman on 7/26/17.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

struct Constants {
    
    static let gradients: [[CGColor]] =
        [[UIColor.tipperNavy.cgColor, UIColor.tipperGreen.cgColor],
        [UIColor.tipperPurple.cgColor, UIColor.babyBlue.cgColor],
        [UIColor.tipperViolet.cgColor, UIColor.tipperPink.cgColor],
        [UIColor.tipperGray.cgColor, UIColor.darkPurple.cgColor]]
    
    

}

extension UIColor {
    static var tipperGreen: UIColor {
        return UIColor(red: 87/255, green: 202/255, blue: 133/255, alpha: 1.0)
    }
    static var tipperNavy: UIColor {
        return UIColor(red: 25/255, green: 79/255, blue: 104/255, alpha: 1.0)
    }
    static var babyBlue: UIColor {
        return UIColor(red: 27/255, green: 206/255, blue: 223/255, alpha: 1.0)
    }
    static var tipperPurple: UIColor {
        return UIColor(red: 91/255, green: 36/255, blue: 122/255, alpha: 1.0)
    }
    static var tipperViolet: UIColor {
        return UIColor(red: 98/255, green: 39/255, blue: 116/255, alpha: 1.0)
    }
    static var tipperPink: UIColor {
        return UIColor(red: 197/255, green: 51/255, blue: 100/255, alpha: 1.0)
    }
    static var darkPurple: UIColor {
        return UIColor(red: 94/255, green: 37/255, blue: 99/255, alpha: 1.0)
    }
    static var tipperGray: UIColor {
        return UIColor(red: 101/255, green: 121/255, blue: 155/255, alpha: 1.0)
    }
}
