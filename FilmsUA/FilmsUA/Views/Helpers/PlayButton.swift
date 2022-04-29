//
//  PlayButton.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 29.04.2022.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60)
                .foregroundColor(.white)
                .opacity(0.3)
                .blur(radius: 1)
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
        }
        .padding(.top, 410)
    }
}
