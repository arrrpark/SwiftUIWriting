//
//  WritingTImeLimitView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/05/01.
//

import SwiftUI

struct WritingTImeLimitView: View {
    @EnvironmentObject var writingViewModel: WritingViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Set time limit")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 300, height: 50)
                HStack {
                    Text("\(writingViewModel.timeLimit) minutes")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrow.up")
                        .resizable()
                        .scaledToFit()
                        .padding([.top, .bottom], 10)
                        .frame(width: 40, height: 40).background(Color.blue)
                        .onTapGesture {
                            writingViewModel.timeLimit += 1
                        }
                    Image(systemName: "arrow.down")
                        .resizable()
                        .scaledToFit()
                        .padding([.top, .bottom], 10)
                        .frame(width: 40, height: 40).background(Color.blue)
                        .onTapGesture {
                            writingViewModel.timeLimit -= 1
                        }
                }.padding([.leading, .trailing], 40).frame(width: 300, height: 100)
                HStack {
                    Text("Cancel").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            writingViewModel.timeLimitViewHidden = true
                        }
                    Text("Confirm").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            writingViewModel.timeLimitViewHidden = true
                            writingViewModel.timeString = writingViewModel.getRestTime()
                            writingViewModel.startTimer()
                        }
                }.frame(width: 300, height: 50)
            }
            .frame(width: 300, height: 220)
            .background(Color(Colors.getColor(hex: Colors.darkStateBlue.rawValue)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
    }
}
