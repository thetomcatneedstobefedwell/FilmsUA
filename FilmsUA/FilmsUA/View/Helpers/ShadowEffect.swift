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
