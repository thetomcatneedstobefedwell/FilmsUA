import Foundation
import Combine

final class FilmListViewModel: ObservableObject {
    @Published var filmCards: [FilmCard] = []
    @Published var queryString: String = "" {
        didSet {
            if !queryString.isEmpty {
                self.isSearched = true
                getFilms(query: queryString, id: nil)
            } else {
                FilmList.page = 1
                self.isSearched = false
                getFilms(query: nil, id: nil)
            }
        }
    }
    @Published var isSearched: Bool = false
    private var cancellable: Set<AnyCancellable> = []
    
    func getFilms(load: Bool = false, query: String?, id: UInt?) -> Void {
        FilmList.page += load ? 1 : 0
        var link: ParsingURL {
            if query != nil && id == nil {
                return .getSearchedFilms(query: queryString)
            } else if id != nil {
                return .getSimilarFilms(id: id!)
            } else {
                return .getPopularFilms
            }
        }
        guard let url: URL = URL(string: link.urlRawValue)
        else { return }
        
        getData(url: url, type: FilmList.self)
            .map(\.results)
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { [weak self] filmCards in
                if load {
                    self?.filmCards += filmCards
                } else {
                    self?.filmCards = filmCards
                }
            })
            .store(in: &cancellable)
    }
    
    enum ParsingURL {
        case getPopularFilms
        case getSearchedFilms(query: String)
        case getSimilarFilms(id: UInt)
        
        var urlRawValue: String {
            switch self {
            case .getPopularFilms:
                return "https://api.themoviedb.org/3/movie/popular?api_key=e92e44d11658d052b0bbaf2e23940f65&page=\(FilmList.page)"
            case .getSearchedFilms(let query):
                return "https://api.themoviedb.org/3/search/movie?api_key=e92e44d11658d052b0bbaf2e23940f65&page=\(FilmList.page)&query=\(query)"
            case .getSimilarFilms(let id):
                return "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=e92e44d11658d052b0bbaf2e23940f65&page=\(FilmList.page)"
            }
        }
    }
}
