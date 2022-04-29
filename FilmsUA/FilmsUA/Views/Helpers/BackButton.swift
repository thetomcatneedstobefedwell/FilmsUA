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
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
    }
    }
}
