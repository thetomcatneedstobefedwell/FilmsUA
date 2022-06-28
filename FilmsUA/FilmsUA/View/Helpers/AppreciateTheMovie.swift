import SwiftUI

struct AppreciateTheMovie: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Appreciate the movie")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            StarsView(rating: 0, frame: 60)
                .font(.system(size: 45))
                .opacity(0.8)
                .padding([.bottom, .horizontal])
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10))
        .foregroundColor(Color(red: 0.109, green: 0.108, blue: 0.119))    }
}
