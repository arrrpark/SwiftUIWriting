//
//  URL+Extension.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/28.
//

import Foundation

extension URL {
    var isDirectory: Bool {
        (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    var subDirectories: [URL] {
        guard isDirectory else { return [] }
        
        return (try? FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]).filter(\.isDirectory)) ?? []
    }
}
