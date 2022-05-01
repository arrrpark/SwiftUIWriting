//
//  UserDefaultsUtil.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/28.
//

import UIKit

enum UserDefaultsKey: String {
    case textSize
    case sortFileKey
}

enum FileSortingValue: String {
    case titleAscending
    case titleDescending
    case creationDateAscending
    case creationDateDescending
    case fileSizeAscending
    case fileSizeDescending
}

struct UserDefualtsUtil {
    static let shared = UserDefualtsUtil()
    
    private init() { }
    
    func setTextSize(_ size: CGFloat) {
        UserDefaults.standard.set(size, forKey: UserDefaultsKey.textSize.rawValue)
    }
    
    func getTextSize() -> CGFloat {
        let size = UserDefaults.standard.float(forKey: UserDefaultsKey.textSize.rawValue)
        return size == 0 ? CGFloat(15) : CGFloat(size)
    }
    
    func setSortFileKey(_ key: FileSortingValue) {
        UserDefaults.standard.set(key.rawValue, forKey: UserDefaultsKey.sortFileKey.rawValue)
    }
    
    func getSortFileKey() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKey.sortFileKey.rawValue) ?? FileSortingValue.creationDateDescending.rawValue
    }
}
