import UIKit

/// EditAttributesViewController: Displays the list of attributes for a product.
///
final class EditAttributesViewController: UIViewController {

    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var addButtonSeparator: UIView!
    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddButton()
        configureAddButtonSeparator()
        registerTableViewCells()
        configureTableView()
        configureNavigationBar()
        handleSwipeBackGesture()
    }
}

// MARK: - View Configuration
private extension EditAttributesViewController {
    func registerTableViewCells() {
        tableView.registerNib(for: ImageAndTitleAndTextTableViewCell.self)
    }

    func configureAddButton() {
        addButton.setTitle(Localization.addNewAttribute, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.applySecondaryButtonStyle()
    }

    func configureAddButtonSeparator() {
        addButtonSeparator.backgroundColor = .systemColor(.separator)
    }

    func configureTableView() {
        view.backgroundColor = .listBackground
        tableView.backgroundColor = .listBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.removeLastCellSeparator()
    }

    func configureNavigationBar() {
        configureTitle()
        configureRightButton()
    }

    func configureTitle() {
        title = Localization.title
    }

    func configureRightButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.setRightBarButton(rightBarButton, animated: false)
    }
}

// MARK: Button Actions & Navigation Handling
extension EditAttributesViewController {
    @objc private func doneButtonTapped() {
        // TODO: Create variation and notify back
    }

    @objc private func addButtonTapped() {
        // TODO: Launch add attribute flow and update product upon completion
    }
}

// MARK: - UITableView conformance
//
extension EditAttributesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 // Temporary
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ImageAndTitleAndTextTableViewCell.self, for: indexPath)

        // Temporary
        let vm = ImageAndTitleAndTextTableViewCell.ViewModel(title: "Color",
                                                             text: "Green, Yellow, Blue",
                                                             numberOfLinesForTitle: 0,
                                                             numberOfLinesForText: 0)
        cell.updateUI(viewModel: vm)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Navigate to edit attribute
    }
}

// MARK: Constants
private extension EditAttributesViewController {
    enum Localization {
        static let addNewAttribute = NSLocalizedString("Add New Attribute", comment: "Action to add new attribute on the Product Attributes screen")
        static let title = NSLocalizedString("Edit Attributes", comment: "Navigation title for the Product Attributes screen")
        static let done = NSLocalizedString("Done", comment: "Button title for the Done Action on the navigation bar")
    }
}