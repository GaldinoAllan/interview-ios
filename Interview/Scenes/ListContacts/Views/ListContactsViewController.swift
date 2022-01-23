import UIKit

class UserIdsLegacy {
    static let legacyIds = [10, 11, 12, 13]
    
    static func isLegacy(id: Int) -> Bool {
        return legacyIds.contains(id)
    }
}

final class ListContactsViewController: UIViewController{

    // MARK: - Views

    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(ContactCell.self, forCellReuseIdentifier: String(describing: ContactCell.self))
        tableView.backgroundView = activity
        tableView.tableFooterView = UIView()
        return tableView
    }()

    // MARK: - Properties

    private var viewModel = ListContactsViewModel()

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.loadContacts()
    }

    // MARK: - Set Up methods
    
    private func setUp() {
        title = "Lista de contatos"
        setUpSubView()
        setUpConstraints()
        setUpDelegates()
    }

    private func setUpSubView() {
        view.addSubview(tableView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    private func setUpDelegates() {
        viewModel.delegate = self
    }

    // MARK: - Contents
    
    func isLegacy(contact: Contact) -> Bool {
        return UserIdsLegacy.isLegacy(id: contact.id)
    }

    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - ListContactsViewModelDelegate

extension ListContactsViewController: ListContactsViewModelDelegate {
    func contactsDidLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
    }

    func contactsLoadFailed(withError error: NetworkErrors) {
        DispatchQueue.main.async {
            self.showAlert(withTitle: "Ops, ocorreu um erro", message: error.localizedDescription)
        }
    }
}
// MARK: - UITableViewDataSource & UITableViewDelegate

extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactCell.self), for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }

        let contact = viewModel.contacts[indexPath.row]
        cell.fullnameLabel.text = contact.name

        if let urlPhoto = URL(string: contact.photoURL) {
            do {
                let data = try Data(contentsOf: urlPhoto)
                let image = UIImage(data: data)
                cell.contactImage.image = image
            } catch _ {}
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contato = viewModel.contacts[indexPath.row]

        guard isLegacy(contact: contato) else {
            showAlert(withTitle: "Você tocou em", message: contato.name)
            return
        }
        showAlert(withTitle: "Atenção", message: "Você tocou no contato sorteado")
    }
}
