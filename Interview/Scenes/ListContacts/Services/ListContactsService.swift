import Foundation

protocol ListContactServiceProtocol {
    func fetchContacts(completionHandler: @escaping (Result<[Contact], NetworkErrors>) -> Void)
}

class ListContactService: ListContactServiceProtocol {
    private let apiURL = "https://run.mocky.io/v3/1d9c3bbe-eb63-4d09-980a-989ad740a9ac"
    private var session: NetworkSession
    private var decoder: JSONDecoder

    init(urlSession: NetworkSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = urlSession
        self.decoder = decoder
    }

    func fetchContacts(completionHandler: @escaping (Result<[Contact], NetworkErrors>) -> Void) {
        guard let api = URL(string: apiURL) else {
            completionHandler(.failure(.invalidUrl))
            return
        }

        session.loadContacts(with: api) { [weak self] (data, response, error) in
            guard let self = self else { return }

            guard error == nil else {
                completionHandler(.failure(
                    .serverError(message: error?.localizedDescription ?? "")))
                return
            }

            guard let jsonData = data else {
                completionHandler(.failure(.emptyResponse))
                return
            }
            
            do {
                let decodedContacts = try self.decoder.decode([Contact].self, from: jsonData)
                completionHandler(.success(decodedContacts))
            } catch let error {
                completionHandler(.failure(.jsonDecoding(message: error.localizedDescription)))
            }
        }
    }
}
