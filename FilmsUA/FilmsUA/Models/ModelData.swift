//
//  ModelData.swift
//  FilmsUA
//
//  Created by Roman Zherebko on 13.04.2022.
//

import Foundation

func getFilms(load: Bool = false, completion: @escaping ([FilmCard]) -> ()) {
    FilmList.page += load ? 1 : 0
    guard let url: URL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e92e44d11658d052b0bbaf2e23940f65&page=\(FilmList.page)")
    else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        let response = try! JSONDecoder().decode(FilmList.self, from: data!)
        let films = response.results
        DispatchQueue.main.async {
            completion(films)
        }
    }
    .resume()
}

func getFilmDetails(id: UInt, completion: @escaping (FilmDetail) -> ()) {
    SimilarFilmList.page = 1
    guard let url: URL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=e92e44d11658d052b0bbaf2e23940f65")
    else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        let film = try! JSONDecoder().decode(FilmDetail.self, from: data!)
        DispatchQueue.main.async {
            completion(film)
        }
    }
    .resume()
}

func getSimilarFilms(id: UInt, load: Bool = false, completion: @escaping ([FilmCard]) -> ()) {
    SimilarFilmList.page += load ? 1 : 0
    guard let url: URL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=e92e44d11658d052b0bbaf2e23940f65&page=\(SimilarFilmList.page)")
    else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        let response = try! JSONDecoder().decode(SimilarFilmList.self, from: data!)
        let similarFilms = response.results
        DispatchQueue.main.async {
            completion(similarFilms)
        }
    }
    .resume()
}

func searchFilms(query: String, load: Bool = false, completion: @escaping ([FilmCard]) -> ()) {
    SearchedList.page += load ? 1 : 0
    guard let url: URL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=e92e44d11658d052b0bbaf2e23940f65&query=\(query)&page=\(SearchedList.page)")
    else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        let films = try! JSONDecoder().decode(SearchedList.self, from: data!).results
        DispatchQueue.main.async {
            completion(films)
        }
    }
    .resume()
}
