//
//  BottomSheetView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/30.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    init(maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = 0
        self.maxHeight = maxHeight
        self.content = content()
    }

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                self.content
            }
            .frame(width: Util.screenBounds.width, height: self.maxHeight, alignment: .top)
            .cornerRadius(20, corners: [ .topLeft, .topRight])
            .frame(height: Util.screenBounds.height, alignment: .bottom)
        }
    }
}
