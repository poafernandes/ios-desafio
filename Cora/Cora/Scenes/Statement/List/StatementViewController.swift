import CoraClientInterfaces
import DesignSystem
import UIKit

final class StatementViewController: UIViewController {
    private lazy var filterView = FilterBuilder.build(items: ["Tudo", "Entrada", "Saída", "Futuro"],
                                                      displayOption: .withActionIcon,
                                                      delegate: self)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.tableHeaderView = nil
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.allowsSelection = true
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StatementTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(StatementTableViewCell.self))
        
        return tableView
    }()
    
    private let viewModel = StatementViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewModel.reloadItems = {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationBar.apply(to: self,
                            title: "Extrato",
                            rightButtonImage: nil,
                            rightButtonAction: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didLoad()
    }
}

extension StatementViewController: ViewConfiguration {
    func configViews() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .white
    }
    
    func buildViews() {
        [filterView,
         tableView].forEach(view.addSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension StatementViewController: FilterDelegateProtocol {
    func didSelect(item: Int) {
        print("didSelect \(item)")
    }
    
    func didTapActionIcon() {
        print("didTapActionIcon")
    }
}

extension StatementViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = StatementHeaderView()
        headerView.setupHeader(with: viewModel.sections[section])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(StatementTableViewCell.self)) as! StatementTableViewCell
        cell.setupCell(with: .init(value: viewModel.items[indexPath.section][indexPath.row].value,
                                   description: viewModel.items[indexPath.section][indexPath.row].description,
                                   receiver: viewModel.items[indexPath.section][indexPath.row].receiver,
                                   time: viewModel.items[indexPath.section][indexPath.row].time,
                                   icon: Icons.icArrowDownIn.image))
        return cell
    }
}

extension StatementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(StatementDetailViewController(), animated: true)
    }
}
