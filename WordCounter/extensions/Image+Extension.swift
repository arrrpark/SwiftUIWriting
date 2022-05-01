//
//  Image+Extension.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/05/01.
//

import SwiftUI

extension Image {
    func imageButtonModifier() -> some View {
        self.renderingMode(.template)
            .resizable()
            .scaledToFill()
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 5)
            .frame(width: 30, height: 30)
    }
}
