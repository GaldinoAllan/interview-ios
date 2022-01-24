import Foundation

struct Contact: Decodable, Equatable {
    let id: Int
    let name: String
    let photoURL: String
}
