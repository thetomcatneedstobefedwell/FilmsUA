import Foundation
import Combine

// Generic parser
func getData<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
        .receive(on: DispatchQueue.main)
        .map(\.data)
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}
