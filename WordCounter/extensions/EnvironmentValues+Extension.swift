//
//  EnvironmentValues+Extension.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/27.
//

import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

private extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}
