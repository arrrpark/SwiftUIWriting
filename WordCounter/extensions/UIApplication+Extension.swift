//
//  UIApplication+Extension.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/30.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
