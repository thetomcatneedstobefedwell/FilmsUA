//
//  BackButton.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 28.04.2022.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        Image(systemName: "xmark.circle.fill")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, .blue)
            .font(.system(size: 30, design: .rounded))
    }
    }
}
