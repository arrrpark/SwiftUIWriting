//
//  DirectoryView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/29.
//

import SwiftUI

struct DirectoryView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    private let gridItem = [GridItem(.fixed(Util.screenBounds.width))]
    private let darkSlateBlue: Color = Color(Colors.getColor(hex: Colors.darkStateBlue.rawValue))
    private let deepGreen: Color = Color(Colors.getColor(hex: Colors.deepGreen.rawValue))
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: gridItem, spacing: 0) {
                        ForEach(0..<homeViewModel.directoryData.count, id: \.self) { index in
                            let data = homeViewModel.directoryData[index]
                            let xOffset = 5 * CGFloat(data.depth) + 10
                            HStack {
                                Image(systemName: "folder")
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .offset(x: xOffset, y: 0)
                                Text(data.directoryName.lastPathComponent)
                                    .foregroundColor(.white)
                                    .offset(x: xOffset, y: 0)
                                Spacer()
                                Image(systemName: data.clicked ? "chevron.down" : "chevron.right")
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .padding()
                                    .onTapGesture {
                                        if !data.clicked {
                                            homeViewModel.getSubDirectories(directory: data.directoryName, depth: data.depth, index: index)
                                        }
                                    }
                            }
                            .onTapGesture { homeViewModel.selectedDirectoryIndex = index }
                            .background(index == homeViewModel.selectedDirectoryIndex ? deepGreen : darkSlateBlue)
                            .frame(width: 300, height: 50)
                        }
                    }
                }.frame(maxWidth: 300, maxHeight: 460)
                Spacer()
                HStack {
                    Text("Cancel").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture { homeViewModel.changeDirectoryVisibility(true) }
                    Text("Move").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            if let index = homeViewModel.selectedDirectoryIndex {
                                homeViewModel.moveFiles(homeViewModel.directoryData[index].directoryName)
                                homeViewModel.changeDirectoryVisibility(true)
                            }
                        }
                }.frame(width: 300, height: 50)
            }
            .frame(width: 300, height: 520)
            .background(darkSlateBlue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
    }
}
