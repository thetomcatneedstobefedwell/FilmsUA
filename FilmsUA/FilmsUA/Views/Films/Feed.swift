//
//  Feed.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 13.04.2022.
//

import SwiftUI

struct Feed: View {
    @State private var films: [FilmCard] = []
    @State private var queryString: String = ""
    @State private var isSearched: Bool = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        NavigationView {
            VStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("DarkGrey"))
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("", text: $queryString)
                            .modifier(PlaceholderStyle(showPlaceHolder: queryString.isEmpty, placeholder: "Search")
                            )
                            .onChange(of: queryString) { queryString in
                                if !queryString.isEmpty {
                                    self.isSearched = true
                                    searchFilms(query: queryString) { films in
                                        self.films = films
                                    }
                                } else {
                                    FilmList.page = 1
                                    SearchedList.page = 1
                                    self.isSearched = false
                                    getFilms() { (films) in
                                        self.films = films
                                    }
                                }
                            }
                    }
                    .foregroundColor(.gray)
                    .padding(.leading, 13)
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(films, id: \.id) { film in
                            NavigationLink {
                                FilmDetails(id: film.id)
                            } label: {
                                FilmRow(film: film)
                            }
                            .onAppear() {
                                if film == films.last {
                                    if isSearched {
                                        searchFilms(query: queryString, load: true) { (films) in
                                            self.films += films
                                        }
                                    } else {
                                        getFilms(load: true) { (films) in
                                            self.films += films
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.black)
                }
                .onAppear() {
                    if self.films.count == 0 {
                        getFilms { (films) in
                            self.films = films
                        }
                    }
                }
            }
            .background(Color(red: 0.124, green: 0.123, blue: 0.129))
            .navigationBarTitle("Films")
        }
    }
}

//struct Feed_Previews: PreviewProvider {
//    static var previews: some View {
//        Feed()
//    }
//}
