//
//  HomeViewModel.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/28.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let directory: String
    let currentDirectory: URL
    let fileManager = FileManager.default
    
    @Published var files: [FileData] = []
    @Published var folderName = ""
    @Published var isClicked: [Bool] = []
    @Published var directoryData: [DirectoryData] = []
    @Published var selectedDirectoryIndex: Int?
    
    @Published var choiceHidden = true
    @Published var backButtonHidden = false
    @Published var createFolderViewHidden = true
    @Published var bottomOptionHidden = true
    @Published var showAlert = false
    @Published var directoryViewHidden = true
    @Published var bottomSheetHidden = true
    
    init(directory: String) {
        self.directory = directory
        self.currentDirectory = Util.documentsURL.appendingPathComponent(directory)
        self.backButtonHidden = self.directory == "Home"
        try? fileManager.createDirectory(at: currentDirectory, withIntermediateDirectories: true)
    }
    
    @discardableResult
    func readFiles() -> Bool {
        files.removeAll()
        
        guard var directoryContents = try? fileManager.contentsOfDirectory(at: currentDirectory, includingPropertiesForKeys: [.nameKey, .fileSizeKey, .creationDateKey], options: .skipsHiddenFiles) else { return false }
        
        directoryContents = directoryContents.sorted(by: { (url1: URL, url2: URL) -> Bool in
            do {
                let key = UserDefualtsUtil.shared.getSortFileKey()
                
                switch key {
                case FileSortingValue.creationDateAscending.rawValue:
                    let values1 = try url1.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    let values2 = try url2.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    if let date1 = values1.creationDate, let date2 = values2.creationDate {
                        return date1.compare(date2) == ComparisonResult.orderedAscending
                    }
                case FileSortingValue.creationDateDescending.rawValue:
                    let values1 = try url1.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    let values2 = try url2.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    if let date1 = values1.creationDate, let date2 = values2.creationDate {
                        return date1.compare(date2) == ComparisonResult.orderedDescending
                    }
                case FileSortingValue.titleAscending.rawValue:
                        let values1 = try url1.resourceValues(forKeys: [.nameKey])
                        let values2 = try url2.resourceValues(forKeys: [.nameKey])
                        
                        if let name1 = values1.name, let name2 = values2.name {
                            return name1.compare(name2) == ComparisonResult.orderedAscending
                        }
                case FileSortingValue.titleDescending.rawValue:
                    let values1 = try url1.resourceValues(forKeys: [.nameKey])
                    let values2 = try url2.resourceValues(forKeys: [.nameKey])
                    
                    if let name1 = values1.name, let name2 = values2.name {
                        return name1.compare(name2) == ComparisonResult.orderedDescending
                    }
                case FileSortingValue.fileSizeAscending.rawValue:
                    let values1 = try url1.resourceValues(forKeys: [.fileSizeKey])
                    let values2 = try url2.resourceValues(forKeys: [.fileSizeKey])
                    if let size1 = values1.fileSize, let size2 = values2.fileSize {
                        return size1 < size2
                    }
                case FileSortingValue.fileSizeDescending.rawValue:
                    let values1 = try url1.resourceValues(forKeys: [.fileSizeKey])
                    let values2 = try url2.resourceValues(forKeys: [.fileSizeKey])
                    if let size1 = values1.fileSize, let size2 = values2.fileSize {
                        return size1 > size2
                    }
                default:
                    let values1 = try url1.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    let values2 = try url2.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                    if let date1 = values1.creationDate, let date2 = values2.creationDate {
                        return date1.compare(date2) == ComparisonResult.orderedDescending
                    }
                }
            } catch {
                
            }
            return true
        })
        
        for content in directoryContents {
            let url = currentDirectory.appendingPathComponent(content.lastPathComponent)
            guard let attributes = try? fileManager.attributesOfItem(atPath: url.path),
                  let fileSizeFromAsset = attributes[FileAttributeKey.size] as? Double,
                  let time = attributes[FileAttributeKey.creationDate] as? Date else {
                continue
            }
            
            files.append(FileData(isDirectory: url.isDirectory,
                                  fileName: "\(content.lastPathComponent)",
                                  fileSize: fileSizeFromAsset / 1024 / 1024,
                                  timeMills: time.millisecondsSince1970))
        }
        
        return true
    }
    
    func createDirectory(_ directoryName: String) -> Bool {
        var result = true
        do {
            let newDirectory = Util.documentsURL.appendingPathComponent(directory).appendingPathComponent(directoryName)
            
            try FileManager.default.createDirectory(atPath: newDirectory.path, withIntermediateDirectories: true, attributes: nil)
            
            if let attributes = try? fileManager.attributesOfItem(atPath: newDirectory.path),
               let fileSizeFromAsset = attributes[FileAttributeKey.size] as? Double,
               let time = attributes[FileAttributeKey.creationDate] as? Date {
                files.append(FileData(isDirectory: true,
                                      fileName: newDirectory.lastPathComponent,
                                      fileSize: fileSizeFromAsset / 1024 / 1024,
                                      timeMills: time.millisecondsSince1970))
            }
        } catch {
            result = false
        }
        return result
    }
    
    func changeChoiceVisibility(_ hidden: Bool? = nil) {
        let isHidden = hidden != nil ? hidden! : !choiceHidden
        if isHidden {
            isClicked = []
        } else {
            isClicked = [Bool](repeating: false, count: files.count)
        }
        choiceHidden = isHidden
    }
    
    func changeDirectoryVisibility(_ hidden: Bool? = nil){
        let isHidden = hidden != nil ? hidden! : !directoryViewHidden
        if isHidden {
            directoryData = []
        } else {
            directoryData.append(DirectoryData(directoryName: Util.documentsURL.appendingPathComponent("Home"), depth: 0, clicked: false))
        }
        directoryViewHidden = isHidden
    }
    
    func removeFiles() -> Bool {
        var indexesToRemove: [Int] = []
        for (index, clicked) in isClicked.enumerated() where clicked {
            let currentFileURL = currentDirectory.appendingPathComponent(files[index].fileName)
            try? fileManager.removeItem(at: currentFileURL)
            
            indexesToRemove.append(index)
        }
        
        indexesToRemove.reverse()
        for index in indexesToRemove {
            files.remove(at: index)
        }
        
        changeChoiceVisibility(true)
        return true
    }
    
    func moveFiles(_ to: URL) {
        var indexesToRemove: [Int] = []
        
        for (index, click) in isClicked.enumerated() where click {
            let tmpFile = files[index]
            let fileURL = Util.documentsURL.appendingPathComponent(directory).appendingPathComponent(tmpFile.fileName)
            let fileURLAfter = to.appendingPathComponent(tmpFile.fileName)
            try? fileManager.moveItem(at: fileURL, to: fileURLAfter)
            indexesToRemove.append(index)
        }

        indexesToRemove.reverse()
        for index in indexesToRemove { files.remove(at: index) }
        changeDirectoryVisibility(true)
        changeChoiceVisibility(true)
    }
    
    func getSubDirectories(directory: URL, depth: Int, index: Int) {
        var tmpData: [DirectoryData] = []
        for directory in directory.subDirectories {
            tmpData.append(DirectoryData(directoryName: directory, depth: depth+1, clicked: false))
        }
        directoryData.insert(contentsOf: tmpData, at: index+1)
        directoryData[index].clicked = true
        selectedDirectoryIndex = nil
    }
    
    func sortFile(_ key: FileSortingValue) {
        UserDefualtsUtil.shared.setSortFileKey(key)
        readFiles()
        bottomSheetHidden = true
    }
}
