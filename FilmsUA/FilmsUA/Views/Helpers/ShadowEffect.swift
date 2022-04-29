//
//  ShadowEffect.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 29.04.2022.
//

import SwiftUI

struct ShadowEffect: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
            )
    }
}
