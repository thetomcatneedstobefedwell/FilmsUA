import SwiftUI

struct Feed: View {
    @StateObject private var viewModel: FilmListViewModel = FilmListViewModel()
    
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.filmCards, id: \.id) { film in
                            NavigationLink {
                                FilmDetails(id: film.id)
                            } label: {
                                FilmRow(film: film)
                            }
                            .onAppear() {
                                if film == viewModel.filmCards.last {
                                    if viewModel.isSearched {
                                        viewModel.getFilms(load: true, query: viewModel.queryString, id: nil)
                                    } else {
                                        viewModel.getFilms(load: true, query: nil, id: nil)
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.black)
                }
                .onAppear() {
                    if self.viewModel.filmCards.count == 0 {
                        viewModel.getFilms(query: nil, id: nil)
                    }
                }
            .background(Color(red: 0.124, green: 0.123, blue: 0.129))
            .navigationBarTitle("Films")
            .searchable(text: $viewModel.queryString)
        }
        .preferredColorScheme(.dark)
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
