//
//  Util.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/27.
//

import UIKit

struct Util {
    static let shared = Util()
    
    private init () {}
    
    private let guidelineBaseWidth = 375.0
    private let guidelineBaseHeight = 667.0
    
    static let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static let screenBounds = UIScreen.main.bounds
    
    func horizontalScale(_ float: CGFloat) -> CGFloat {
        (UIScreen.main.bounds.width / CGFloat(guidelineBaseWidth)) * float
    }
    
    func verticalScale(_ float: CGFloat) -> CGFloat {
        (UIScreen.main.bounds.height / CGFloat(guidelineBaseHeight)) * float
    }
    
    func moderateScale(_ float: CGFloat, factor: CGFloat = 0.5) -> CGFloat {
        float + (horizontalScale(float) - float) * factor
    }
}
