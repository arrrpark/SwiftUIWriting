//
//  WritingOptionBar.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/05/01.
//

import SwiftUI

struct WritingOptionBar: View {
    @EnvironmentObject var writingViewModel: WritingViewModel
    @Binding var presentation: PresentationMode
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .imageButtonModifier()
                .onTapGesture {
                    if writingViewModel.text.count > 0 {
                        writingViewModel.showAlert = true
                    } else {
                        presentation.dismiss()
                    }
                }
            Spacer()
            Image(systemName: "arrow.down")
                .imageButtonModifier()
                .onTapGesture {
                    writingViewModel.minusTextSize()
                }
            Image(systemName: "arrow.up")
                .imageButtonModifier()
                .onTapGesture {
                    writingViewModel.plusTextSize()
                }
            Image(systemName: "square.and.arrow.up")
                .imageButtonModifier()
                .onTapGesture {
                    guard let vc = UIApplication.shared.windows.first?.rootViewController else { return }
                    
                    let shareActivity = UIActivityViewController(activityItems: [writingViewModel.text], applicationActivities: nil)
                    shareActivity.popoverPresentationController?.sourceView = vc.view
                    shareActivity.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height * 2 / 3, width: 0, height: 0)
                    shareActivity.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
                    vc.present(shareActivity, animated: true, completion: nil)
                }
            Image(systemName: "arrow.down.doc")
                .imageButtonModifier()
                .onTapGesture {
                    if writingViewModel.mode == .new {
                        writingViewModel.saveWritingViewHidden = false
                    } else {
                        if writingViewModel.saveEdit() {
                            presentation.dismiss()
                        }
                    }
                }
        }
        .padding([.leading, .trailing], 10)
        .frame(height: 40)
    }
}
