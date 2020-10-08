import UIKit

/// Screen that allows the user to refund items (products and shipping) of an order
///
final class IssueRefundViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var tableFooterView: UIView!
    @IBOutlet private var tableHeaderView: UIView!

    @IBOutlet private var itemsSelectedLabel: UILabel!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var selectAllButton: UIButton!

    private let viewModel = IssueRefundViewModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.updateHeaderHeight()
        tableView.updateFooterHeight()
    }
}

// MARK: Actions
private extension IssueRefundViewController {
    @IBAction func nextButtonWasPressed(_ sender: Any) {
        navigationController?.pushViewController(RefundConfirmationViewController(), animated: true)
    }

    @IBAction func selectAllButtonWasPressed(_ sender: Any) {
        print("Select All button pressed")
    }
}

// MARK: View Configuration
private extension IssueRefundViewController {

    func configureNavigationBar() {
        title = viewModel.title
        addCloseNavigationBarButton(title: Localization.cancelTitle)
    }

    func configureTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .listBackground
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        configureFooterView()
        configureHeaderView()
    }

    func registerCells() {
        tableView.registerNib(for: RefundItemTableViewCell.self)
        tableView.registerNib(for: RefundProductsTotalTableViewCell.self)
        tableView.registerNib(for: RefundShippingDetailsTableViewCell.self)
        tableView.registerNib(for: SwitchTableViewCell.self)
    }

    func configureHeaderView() {
        selectAllButton.applyLinkButtonStyle()
        selectAllButton.contentEdgeInsets = .zero
        selectAllButton.setTitle(Localization.selectAllTitle, for: .normal)

        itemsSelectedLabel.applySecondaryBodyStyle()
        itemsSelectedLabel.text = viewModel.selectedItemsTitle
    }

    func configureFooterView() {
        nextButton.applyPrimaryButtonStyle()
        nextButton.setTitle(Localization.nextTitle, for: .normal)
    }
}

// MARK: TableView Delegate & DataSource
extension IssueRefundViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[safe: section]?.rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowViewModel = viewModel.sections[safe: indexPath.section]?.rows[safe: indexPath.row] else {
            return UITableViewCell()
        }

        switch rowViewModel {
        case let viewModel as RefundItemViewModel:
            let cell = tableView.dequeueReusableCell(RefundItemTableViewCell.self, for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case let viewModel as RefundProductsTotalViewModel:
            let cell = tableView.dequeueReusableCell(RefundProductsTotalTableViewCell.self, for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case let viewModel as IssueRefundViewModel.ShippingSwitchViewModel:
            let cell = tableView.dequeueReusableCell(SwitchTableViewCell.self, for: indexPath)
            cell.title = viewModel.title
            cell.isOn = viewModel.isOn
            return cell
        case let viewModel as RefundShippingDetailsViewModel:
            let cell = tableView.dequeueReusableCell(RefundShippingDetailsTableViewCell.self, for: indexPath)
            cell.configure(with: viewModel)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: Constants
private extension IssueRefundViewController {
    enum Localization {
        static let nextTitle = NSLocalizedString("Next", comment: "Title of the next button in the issue refund screen")
        static let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel button title in the issue refund screen")
        static let selectAllTitle = NSLocalizedString("Select All", comment: "Select all button title in the issue refund screen")
    }
}
