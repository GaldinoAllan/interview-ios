import Foundation

struct Contact: Decodable, Equatable {
    var id: Int
    var name: String
    var photoURL: String
}
