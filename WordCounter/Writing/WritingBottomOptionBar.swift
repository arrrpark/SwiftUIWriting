//
//  WritingBottomOptionBar.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/05/01.
//

import SwiftUI

struct WritingBottomOptionBar: View {
    @EnvironmentObject var writingViewModel: WritingViewModel
    
    var body: some View {
        HStack {
            ZStack {
                if !writingViewModel.timeStarted {
                    Image(systemName: "clock")
                        .imageButtonModifier()
                        .onTapGesture {
                            writingViewModel.timeLimitViewHidden = false
                        }
                } else {
                    Text(writingViewModel.timeString).onReceive(writingViewModel.timer) { time in
                        writingViewModel.timeString = writingViewModel.getRestTime()
                    }
                }
            }
            Spacer()
            Text("\(writingViewModel.getWordCount()) words / \(writingViewModel.text.count) characters")
        }.frame(width: Util.screenBounds.width - 30, height: 40)
    }
}

