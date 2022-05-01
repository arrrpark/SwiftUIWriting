//
//  OrderBySelectionView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/30.
//

import SwiftUI

struct OrderBySelectionView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SortItemView(imageName: "arrow.up", text: "Name - A to Z")
                .onTapGesture { homeViewModel.sortFile(.titleAscending) }
            SortItemView(imageName: "arrow.down", text: "Name - Z to A")
                .onTapGesture { homeViewModel.sortFile(.titleDescending) }
            SortItemView(imageName: "arrow.up", text: "Oldest first")
                .onTapGesture { homeViewModel.sortFile(.creationDateDescending) }
            SortItemView(imageName: "arrow.down", text: "Newest first")
                .onTapGesture { homeViewModel.sortFile(.creationDateAscending) }
            SortItemView(imageName: "arrow.up", text: "Small size first")
                .onTapGesture { homeViewModel.sortFile(.fileSizeAscending) }
            SortItemView(imageName: "arrow.down", text: "Large size first")
                .onTapGesture { homeViewModel.sortFile(.fileSizeDescending) }
            Spacer()
        }
        .frame(width: Util.screenBounds.width, height: 300 + safeAreaInsets.bottom)
        .background(Color.blue)
    }
}

struct SortItemView: View {
    let imageName: String
    let text: String
    
    init(imageName: String, text: String) {
        self.imageName = imageName
        self.text = text
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.white)
            Text(text)
                .padding(.leading, 10)
                .foregroundColor(Color.white)
                .offset(x: 20, y: 0)
            Spacer()
        }.frame(height: 50).padding([.leading, .trailing], Util.shared.horizontalScale(30))
    }
}
