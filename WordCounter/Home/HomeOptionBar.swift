//
//  HomeOptionBar.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/29.
//

import SwiftUI

struct HomeOptionBar: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @Binding var presentation: PresentationMode
    
    var body: some View {
        HStack {
            if !homeViewModel.backButtonHidden {
                Image(systemName: "arrow.left")
                    .imageButtonModifier()
                    .onTapGesture {
                        presentation.dismiss()
                    }
            }
            Spacer()
            Image(systemName: "folder.badge.plus")
                .imageButtonModifier()
                .onTapGesture {
                    homeViewModel.createFolderViewHidden = false
                }
            Image(systemName: "arrow.up.arrow.down")
                .imageButtonModifier()
                .onTapGesture {
                    homeViewModel.bottomSheetHidden = false
                }
            Image(systemName: "checkmark")
                .imageButtonModifier()
                .onTapGesture {
                    homeViewModel.changeChoiceVisibility()
                }
        }
        .padding([.leading, .trailing], 10)
        .frame(height: 40)
    }
}
