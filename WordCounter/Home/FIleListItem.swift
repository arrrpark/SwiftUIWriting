//
//  FIleListItem.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/29.
//

import SwiftUI

struct FileListItem: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let file: FileData
    let index: Int
    
    init(file: FileData, index: Int) {
        self.file = file
        self.index = index
    }
    
    var body: some View {
        HStack {
            let imageName = file.isDirectory ? "folder" : "text.book.closed"
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
                .scaledToFill()
                .frame(width: 50, height: 50)
                .offset(x: 20, y: 0)
            VStack(alignment: .leading, spacing: 10) {
                Text(file.fileName)
                    .foregroundColor(Color.black)
                Text(Date().currentTimeMillsToString(time: file.timeMills / 1000))
                    .foregroundColor(Color.black)
                Spacer()
            }
            .frame(height: 100)
            .offset(x: 40, y: 20)
            Spacer()
            if !homeViewModel.choiceHidden {
                let choosen = homeViewModel.isClicked[index]
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(choosen ? .red : .black)
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .offset(x: -20, y: 0)
                    .onTapGesture {
                        homeViewModel.isClicked[index] = !homeViewModel.isClicked[index]
                    }
            }
        }
        .frame(width: Util.screenBounds.width, height: 100)
    }
}
