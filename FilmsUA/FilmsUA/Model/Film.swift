import Foundation

protocol Film: Codable {
    var id: UInt { get }
    var poster_path: String? { get }
    var title: String? { get }
    var vote_average: Float? { get }
}

struct FilmCard: Film, Equatable {
    var id: UInt
    var poster_path: String?
    var title: String?
    var vote_average: Float?
    var pathToImage: String {
        return "https://image.tmdb.org/t/p/w500" + (poster_path ?? "")
    }
}

struct FilmDetail: Film {
    var id: UInt
    var poster_path: String?
    var title: String?
    var genres: Array<Genre>?
    var release_date: String?
    var vote_average: Float?
    var overview: String?
    var pathToImage: String {
        return "https://image.tmdb.org/t/p/w500" + (poster_path ?? "")
    }
}
