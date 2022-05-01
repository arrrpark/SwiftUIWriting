//
//  WritingSaveView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/05/01.
//

import SwiftUI

struct WritingSaveView: View {
    @EnvironmentObject var writingViewModel: WritingViewModel
    @Binding var presentation: PresentationMode
   
    let onSaved: () -> ()
    
    init(presentation: Binding<PresentationMode>, onSaved: @escaping () -> ()) {
        self._presentation = presentation
        self.onSaved = onSaved
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Write essay name")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 300, height: 50)
                TextField("Essay name", text: $writingViewModel.essayName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 280, height: 50)
                HStack {
                    Text("Cancel").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            writingViewModel.saveWritingViewHidden = true
                            writingViewModel.essayName = ""
                        }
                    Text("Confirm").frame(width: 140, height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .onTapGesture {
                            writingViewModel.saveWritingViewHidden = true
                            if writingViewModel.saveWriting() {
                                presentation.dismiss()
                                onSaved()
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
