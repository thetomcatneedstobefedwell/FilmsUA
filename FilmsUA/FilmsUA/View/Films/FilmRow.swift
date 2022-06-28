import SwiftUI

struct FilmRow: View {
    let film: FilmCard
    
    var body: some View {
        VStack(alignment: .leading) {
            if film.poster_path != nil {
                AsyncImage(url: URL(string: film.pathToImage)) { image in
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 200)
                .padding(.top, 8.0)
            }
            if film.title != nil {
                Text(film.title!)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(.white)
            }
            if film.vote_average != nil {
                HStack {
                    StarsView(rating: (film.vote_average! / 2), frame: 12)
                        .font(.caption)
                    Text(String(film.vote_average!))
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                .padding(.top, -10)
                .font(.callout)
            }
        }
        .padding()
    }
}
