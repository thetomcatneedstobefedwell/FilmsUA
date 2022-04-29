//
//  SimilarFilms.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 26.04.2022.
//

import SwiftUI

struct SimilarFilms: View {
    @State private var films: [FilmCard] = []
    var id: UInt
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(films, id: \.id) { film in
                    NavigationLink {
                        FilmDetails(id: film.id)
                    } label: {
                        VStack(alignment: .leading) {
                            if film.poster_path != nil {
                                let imageUrl: String = pathToImage + film.poster_path!
                                AsyncImage(url: URL(string: imageUrl)) { image in
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
                        if film == films.last {
                            getSimilarFilms(id: self.id, load: true) { (films) in
                                self.films += films
                            }
                        }
                    }
                }
            }
        } .onAppear() {
            if self.films.count == 0 {
                getSimilarFilms(id: self.id) { (films) in
                    self.films = films
                }
            }
        }
        .background(Color.black)
    }
}

//struct SimilarFilms_Previews: PreviewProvider {
//    static var previews: some View {
//        SimilarFilms(id: 500)
//    }
//}
