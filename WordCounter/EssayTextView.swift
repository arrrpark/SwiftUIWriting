//
//  TextView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/27.
//

import SwiftUI
 
struct EssayTextView: UIViewRepresentable {
 
    @Binding var text: String
    @Binding var textSize: CGFloat
 
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
 
        textView.font = UIFont.systemFont(ofSize: textSize)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.delegate = context.coordinator
        
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.systemFont(ofSize: textSize)
    }
    
    func makeCoordinator() -> EssayTextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var control: EssayTextView

        init(_ control: EssayTextView) {
            self.control = control
        }
        
        func textViewDidChange(_ textView: UITextView) {
            control.text = textView.text
        }
    }
}
