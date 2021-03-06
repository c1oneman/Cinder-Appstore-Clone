//
//  Extentions.swift
//  Cinder
//
//  Created by Clayton Loneman on 12/8/18.
//  Copyright © 2018 Clayton Loneman. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
extension UIColor {
    enum ColorEnum: String {
        case red   // = "red"
        case green // = "green"
        case blue  // = "blue"
        case pink  // = "pink"
        
        func toColor() -> UIColor {
            switch self {
            case .red:
                return UIColor(rgb: 0xf06449)
            case .green:
                return UIColor(rgb: 0x34435e)
            case .blue:
                return UIColor(rgb: 0x008dd5)
            case .pink:
                return .darkGray
            }
        }
    }
    
    static func fromString(name: String) -> UIColor? {
        return ColorEnum(rawValue: name)?.toColor()
    }
}

extension Array {
    func randomElement() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}
