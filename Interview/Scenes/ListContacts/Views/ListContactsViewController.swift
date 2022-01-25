import UIKit

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

    private var okDialog = "OK"
    private var contactsListScreenTitle = "Lista de contatos"
    
    private let viewModel: ListContactsViewModel

    // MARK: - Initializers

    init(viewModel: ListContactsViewModel = ListContactsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.loadContacts()
    }

    // MARK: - Set Up methods
    
    private func setUp() {
        title = contactsListScreenTitle
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
    
    private func showAlert(with alertInfo: (title: String, message: String)) {
        let alert = UIAlertController(title: alertInfo.title,
                                      message: alertInfo.message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okDialog, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

// MARK: - ListContactsViewModelDelegate

extension ListContactsViewController: ListContactsViewModelDelegate {
    func contactsDidLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.activity.stopAnimating()
        }
    }

    func contactsLoadFailed(withErrorInfo errorInfo: (title: String, message: String)) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showAlert(with: errorInfo)
        }
    }
}
// MARK: - UITableViewDataSource & UITableViewDelegate

extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: String(describing: ContactCell.self),
                                     for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        cell.fullName = viewModel.contacts[indexPath.row].name
        cell.imageUrl = viewModel.contacts[indexPath.row].photoURL
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertInfo = viewModel.selectContactFromList(at: indexPath)
        showAlert(with: alertInfo)
    }
}
