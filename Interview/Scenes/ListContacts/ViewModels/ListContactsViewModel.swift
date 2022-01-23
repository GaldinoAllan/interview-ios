import Foundation

protocol ListContactsViewModelDelegate: AnyObject {
    func contactsDidLoad()
    func contactsLoadFailed(withError error: NetworkErrors)
}

class ListContactsViewModel {
    private let service: ListContactServiceProtocol
    private(set) var contacts = [Contact]()

    weak var delegate: ListContactsViewModelDelegate?
    
    init(service: ListContactServiceProtocol = ListContactService()) {
        self.service = service
    }
    
    func loadContacts() {
        service.fetchContacts { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let contacts):
                self.contacts = contacts
                self.delegate?.contactsDidLoad()
            case .failure(let error):
                self.delegate?.contactsLoadFailed(withError: error)
            }
        }
    }
}
