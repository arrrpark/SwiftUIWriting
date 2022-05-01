//
//  HomeBottomOptionBar.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/29.
//

import SwiftUI

struct HomeBottomOptionBar: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                Image(systemName: "arrowshape.turn.up.right")
                    .imageButtonModifier()
                    .colorMultiply(.black)
                Text("Move")
            }
            .frame(width: Util.screenBounds.width / 2, height: 40)
            .onTapGesture {
                homeViewModel.changeDirectoryVisibility(false)
            }
            HStack {
                Image(systemName: "trash")
                    .imageButtonModifier()
                    .colorMultiply(.black)
                Text("Remove")
            }
            .frame(width: Util.screenBounds.width / 2, height: 50)
            .onTapGesture {
                homeViewModel.showAlert = true
            }
        }.frame(width: Util.screenBounds.width, height: 50 + safeAreaInsets.bottom)
    }
}
