//
//  Date+Extension.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/28.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func currentTimeMillsToString(time: Int64) -> String {
        let formatter = DateFormatter()
        let timeInterval = TimeInterval(integerLiteral: time)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date(timeIntervalSince1970: timeInterval))
    }
}
