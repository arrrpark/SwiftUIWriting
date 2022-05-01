//
//  WritingView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/27.
//

import SwiftUI

struct WritingView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.presentationMode) var presentation
    
    @StateObject var writingViewModel: WritingViewModel
    
    let onSaved: () -> ()
    
    init(directory: String, fileName: String? = nil, onSaved: @escaping () -> ()) {
       _writingViewModel = StateObject(wrappedValue: WritingViewModel(directory: directory, fileName: fileName))
        self.onSaved = onSaved
    }
    
    var body: some View {
        ZStack {
            VStack {
                WritingOptionBar(presentation: presentation).environmentObject(writingViewModel)
                
                EssayTextView(text: $writingViewModel.text, textSize: $writingViewModel.textSize)
                    .frame(width: Util.screenBounds.width - 30, height: Util.screenBounds.height - 120 - safeAreaInsets.bottom)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.black))
                
                WritingBottomOptionBar().environmentObject(writingViewModel)
            }
            .frame(width: Util.screenBounds.width, height: Util.screenBounds.height - safeAreaInsets.top - safeAreaInsets.bottom)
            .padding(.top, safeAreaInsets.top)
            .padding(.bottom, safeAreaInsets.bottom)
            .ignoresSafeArea(.keyboard)
            
            if !writingViewModel.timeLimitViewHidden {
                WritingTImeLimitView().environmentObject(writingViewModel)
            }
            
            if !writingViewModel.saveWritingViewHidden {
                WritingSaveView(presentation: presentation, onSaved: onSaved).environmentObject(writingViewModel)
            }
        }.ignoresSafeArea().alert(isPresented: $writingViewModel.showAlert) {
            Alert(title: Text("Warning"),
                  message: Text("Do you want to quit without saving?"),
                  primaryButton: .default(Text("Cancel"), action: {
                writingViewModel.showAlert = false
            }), secondaryButton: .default(Text("Confirm"), action: {
                writingViewModel.showAlert = false
                presentation.wrappedValue.dismiss()
            }))
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WritingView(directory: "", onSaved: { })
        }
    }
}
