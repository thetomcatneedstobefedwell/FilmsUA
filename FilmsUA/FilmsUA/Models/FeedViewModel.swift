//
//  FeedViewModel.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 16.06.2022.
//

import Foundation
import Combine

final class FeedViewModel: ObservableObject {
    @Published var filmCards: [FilmCard] = []
    
    private var cancellable: Set<AnyCancellable> = []
    
    func getPopularFilms(load: Bool = false) -> Void {
        guard let url: URL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e92e44d11658d052b0bbaf2e23940f65&page=\(FilmList.page)")
        else { return }
        
        getData(url: url, type: FilmList.self)
            .map(\.results)
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { [weak self] filmCards in
                self?.filmCards = filmCards
            })
            .store(in: &cancellable)
    }
}
