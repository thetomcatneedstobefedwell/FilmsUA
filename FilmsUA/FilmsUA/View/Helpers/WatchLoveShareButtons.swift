import SwiftUI

struct WatchLoveShareButtons: View {
    var body: some View {
        HStack(spacing: 60) {
            ZStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(red: 0.109, green: 0.108, blue: 0.119))
                    .blur(radius: 1)
                Image(systemName: "eye")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            ZStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(red: 0.109, green: 0.108, blue: 0.119))
                    .blur(radius: 1)
                Image(systemName: "heart")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            ZStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(Color(red: 0.109, green: 0.108, blue: 0.119))
                    .blur(radius: 1)
                Image(systemName: "arrowshape.turn.up.right")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
        }
        .padding()
    }
}
