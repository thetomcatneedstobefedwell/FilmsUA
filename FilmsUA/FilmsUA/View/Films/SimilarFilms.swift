import SwiftUI

struct SimilarFilms: View {
    @StateObject private var viewModel: FilmListViewModel = FilmListViewModel()
    var id: UInt
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(viewModel.filmCards, id: \.id) { film in
                    NavigationLink {
                        FilmDetails(id: film.id)
                    } label: {
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
                                    .padding(.top, 5)
                                    .padding(.bottom, -2)
                            }
                            if film.vote_average != nil {
                                HStack {
                                    StarsView(rating: (film.vote_average! / 2), frame: 10)
                                        .font(.caption)
                                    Text(String(format: "%.1f", film.vote_average!))
                                        .fontWeight(.bold)
                                        .foregroundColor(.orange)
                                }
                                .font(.callout)
                            }
                        }
                        .frame(width: 150)
                        .padding()
                    }
                    .onAppear() {
                        if film == viewModel.filmCards.last {
                            viewModel.getFilms(load: true, query: nil, id: self.id)
                        }
                    }
                }
            }
        } .onAppear() {
            if self.viewModel.filmCards.count == 0 {
                viewModel.getFilms(query: nil, id: self.id)
            }
        }
        .background(Color.black)
    }
}

struct SimilarFilms_Previews: PreviewProvider {
    static var previews: some View {
        SimilarFilms(id: 500)
    }
}
