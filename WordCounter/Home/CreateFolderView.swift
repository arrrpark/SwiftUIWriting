//
//  CreateFolderView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/29.
//

import SwiftUI

struct CreateFolderView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Write folder name")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 300, height: 50)
                TextField("Folder name", text: $homeViewModel.folderName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 260, height: 50)
                HStack {
                    Text("Cancel").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            homeViewModel.createFolderViewHidden = true
                            homeViewModel.folderName = ""
                        }
                    Text("Confirm").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            homeViewModel.createFolderViewHidden = true
                            if homeViewModel.createDirectory(homeViewModel.folderName) {
                                homeViewModel.readFiles()
                                homeViewModel.folderName = ""
                            }
                        }
                }.frame(width: 300, height: 50)
            }
            .frame(width: 300, height: 170)
            .background(Color(Colors.getColor(hex: Colors.darkStateBlue.rawValue)))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
    }
}
