//
//  Placeholder.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 27.04.2022.
//

import SwiftUI

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
            }
            content
        }
    }
}
