import UIKit

class ContactCell: UITableViewCell {

    // MARK: - Views

    private lazy var contactImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Properties

    var fullName: String? {
        didSet {
            fullNameLabel.text = fullName
        }
    }

    var imageUrl: String? {
        didSet {
            imageUrlDidChange(with: imageUrl)
        }
    }

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    // MARK: - Lifecycle methods

    override func prepareForReuse() {
        super.prepareForReuse()
        fullName = nil
        imageUrl = nil
    }

    // MARK: - Set Up methods
    
    private func setUp() {
        setUpSubViews()
        setUpConstraints()
    }

    private func setUpSubViews() {
        contentView.addSubview(contactImage)
        contentView.addSubview(fullNameLabel)
    }

    private func setUpConstraints() {
        setUpContactImageConstraints()
        setUpFullNameLabelConstraints()
    }

    private func setUpContactImageConstraints() {
        NSLayoutConstraint.activate([
            contactImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contactImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: 100),
            contactImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setUpFullNameLabelConstraints() {
        NSLayoutConstraint.activate([
            fullNameLabel.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor,
                                                   constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -15),
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            fullNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func imageUrlDidChange(with imageUrl: String?) {
        guard let imageUrl = imageUrl,
              let urlPhoto = URL(string: imageUrl) else { return }

        do {
            let data = try Data(contentsOf: urlPhoto)
            let image = UIImage(data: data)
            contactImage.image = image
        } catch _ {}
    }
}
