//
//  UIColor+Extension.swift
//  Extensions
//
//  Created by Logic on 2019/11/14.
//

import Foundation

public extension UIColor {
    
    class func color(hexNumber: UInt64, alpha: CGFloat) -> UIColor {
        return UIColor(red: (CGFloat(((Float)((hexNumber & 0xFF0000) >> 16)) / 255.0)),
                       green: (CGFloat(((Float)((hexNumber & 0xFF00) >> 8)) / 255.0)),
                       blue: (CGFloat(((Float)(hexNumber & 0xFF)) / 255.0)),
                       alpha: alpha)
    }
    
    class func color(hexNumber: UInt64) -> UIColor {
        return UIColor(red: (CGFloat(((Float)((hexNumber & 0xFF0000) >> 16)) / 255.0)),
                       green: (CGFloat(((Float)((hexNumber & 0xFF00) >> 8)) / 255.0)),
                       blue: (CGFloat(((Float)(hexNumber & 0xFF)) / 255.0)),
                       alpha: 1.0)
    }
    
    class func color(hexString: String, alpha: CGFloat) -> UIColor {
        var value = 0 as UInt64
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = hexString.hasPrefix("0x") ? 2 : hexString.hasPrefix("#") ? 1 : 0
        scanner.scanHexInt64(&value)
        return color(hexNumber: value, alpha: alpha)
    }
    
    class func color(hexString: String) -> UIColor {
        var value = 0 as UInt64
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = hexString.hasPrefix("0x") ? 2 : hexString.hasPrefix("#") ? 1 : 0
        scanner.scanHexInt64(&value)
        return color(hexNumber: value, alpha: 1.0)
    }
}
