//
//  Colors.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/05/01.
//

import UIKit

enum Colors: String {
    case blueJay = "#2B547E"
    case darkStateBlue = "#2B3856"
    case deepGreen = "#235264"
    case deepSkyBlue = "#64AAFF"
    case skyBlue = "#CCE1FF"
    
    static func getColor(hex: String, alpht: Double = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
