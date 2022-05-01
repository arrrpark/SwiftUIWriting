//
//  WritingViewModel.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/28.
//

import SwiftUI
import Combine

enum WritingMode {
    case new
    case edit
}

class WritingViewModel: ObservableObject {
    var cancellable = Set<AnyCancellable>()
    
    private let directory: String
    let fileName: String?
    let mode: WritingMode
    
    @Published var showAlert = false
    
    @Published var text = ""
    @Published var textSize: CGFloat = Util.shared.moderateScale(UserDefualtsUtil.shared.getTextSize())
    @Published var timeLimit = 30
    @Published var timeLimitViewHidden = true
    @Published var timeStarted = false
    @Published var timeString = ""
    
    @Published var essayName = ""
    @Published var saveWritingViewHidden = true
    
    private var counter = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    let fileManager = FileManager.default
    
    init(directory: String, fileName: String? = nil) {
        self.directory = directory
        
        guard let fileName = fileName,
              let textFromFile = try? String(contentsOf: Util.documentsURL.appendingPathComponent(directory).appendingPathComponent(fileName)) else {
            self.mode = .new
            self.fileName = nil
            return
        }
        
        self.mode = .edit
        self.fileName = fileName
        self.text = textFromFile
    }
    
    func getWordCount() -> Int {
        return text.split(separator: " ").count
    }
    
    func startTimer() {
        timeStarted = true
        timer.connect().store(in: &cancellable)
    }
    
    func getRestTime() -> String {
        let restSeconds = timeLimit * 60 - counter
        let minutes = restSeconds / 60
        let seconds = restSeconds % 60
        
        var time = ""
        
        if minutes >= 10 {
            time = "\(minutes)"
        } else {
            time = "0\(minutes)"
        }
        
        if seconds >= 10 {
            time += ":\(seconds)"
        } else {
            time += ":0\(seconds)"
        }
        
        counter += 1
        return time
    }
    
    func plusTextSize() {
        let size = Util.shared.moderateScale(textSize + 1)
        guard size < Util.shared.moderateScale(25) else { return }
        
        UserDefualtsUtil.shared.setTextSize(size)
        textSize = size
    }
    
    func minusTextSize() {
        let size = Util.shared.moderateScale(textSize - 1)
        guard size > Util.shared.moderateScale(15) else { return }
        
        UserDefualtsUtil.shared.setTextSize(size)
        textSize = size
    }
    
    func saveWriting() -> Bool {
        let url = Util.documentsURL.appendingPathComponent(directory)
        let docURL = url.appendingPathComponent("\(essayName).txt")
        
        guard !fileManager.fileExists(atPath: docURL.path), text.count > 0 else { return false }
        
        do {
            try text.write(to: docURL, atomically: true, encoding: .utf8)
        } catch {
            return false
        }
        
        return true
    }
    
    func saveEdit() -> Bool {
        guard let fileName = fileName else { return false }

        let url = Util.documentsURL.appendingPathComponent(directory)
        let docURL = url.appendingPathComponent(fileName)
        
        guard text.count > 0 else { return false }
        
        do {
            try text.write(to: docURL, atomically: true, encoding: .utf8)
        } catch {
            return false
        }
        
        return true
    }
}
