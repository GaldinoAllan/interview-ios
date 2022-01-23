import Foundation

protocol ListContactsViewModelDelegate: AnyObject {
    func contactsDidLoad()
    func contactsLoadFailed(withErrorInfo errorInfo: (title: String, message: String))
}

class ListContactsViewModel {

    // MARK: - Properties

    private let service: ListContactServiceProtocol
    private(set) var contacts = [Contact]()

    weak var delegate: ListContactsViewModelDelegate?

    private let contactsListLoadFailedTitle = "Ops, ocorreu um erro"
    private let notLegacyContactTitle = "Você tocou em"
    private let atentionTitle = "Atenção"
    private let legacyContactMessage = "Você tocou no contato sorteado"

    // MARK: - Initializer
    
    init(service: ListContactServiceProtocol = ListContactService()) {
        self.service = service
    }

    // MARK: - Contents
    
    func loadContacts() {
        service.fetchContacts { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let contacts):
                self.contacts = contacts
                self.delegate?.contactsDidLoad()
            case .failure(let error):
                self.delegate?
                    .contactsLoadFailed(withErrorInfo: (title: self.contactsListLoadFailedTitle,
                                                        message: error.localizedDescription))
            }
        }
    }

    func selectContactFromList(at indexPath: IndexPath) -> (title: String, message: String){
        let contact = contacts[indexPath.row]
        let isLegacy = [10, 11, 12, 13].contains(contact.id)

        guard isLegacy else {
            return (title: notLegacyContactTitle, message: contact.name)
        }

        return (title: atentionTitle, message: legacyContactMessage)
    }
}
