import Foundation
import Combine

final class FilmDetailsViewModel: ObservableObject {
    @Published var film: [FilmDetail] = []
    private var cancellable: Set<AnyCancellable> = []
    
    func getFilmDetails(id: UInt) -> Void {
        FilmList.page = 1
        guard let url: URL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=e92e44d11658d052b0bbaf2e23940f65")
        else { return }
        
        getData(url: url, type: FilmDetail.self)
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { [weak self] filmDetails in
                self?.film = [filmDetails]
            })
            .store(in: &cancellable)
    }
    
    func stringDateToYear(date: String) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date!)
    }
}
