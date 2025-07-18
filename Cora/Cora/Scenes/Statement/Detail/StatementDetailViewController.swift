import DesignSystem
import UIKit

class StatementDetailViewController: UIViewController {
    let titleLabel = UILabel.buildStyle(size: .bodyOne, weight: .bold, textColor: Colors.offBlack.uiColor)
    let content = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationBar.apply(to: self,
                            title: "Detalhes da transferência",
                            rightButtonImage: nil,
                            rightButtonAction: nil)
    }
}

extension StatementDetailViewController: ViewConfiguration {
    func configViews() {
        view.backgroundColor = .white
        titleLabel.text = "Transferência enviada"
        
        content.axis = .vertical
        content.spacing = 24
        content.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buildViews() {
        view.addSubview(content)
        
        content.addArrangedSubview(ItemView(title: "Valor", value: "R$ 154,00"))
        content.addArrangedSubview(ItemView(title: "Data", value: "Hoje - 12/10/2019"))
        content.addArrangedSubview(ItemView(title: "De", value: "Dev iOS"))
        content.addArrangedSubview(ItemView(title: "Para", value: "Chapter iOS"))
        content.addArrangedSubview(ItemView(title: "Descrição", value: "Developed by the Intel Corporation, HDCP stands for high-bandwidth digital content protection. As the descriptive name implies."))
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            content.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }
}

class ItemView: UIStackView {
    private let titleLabel = UILabel.buildStyle(size: .bodyTwo, weight: .regular, textColor: Colors.offBlack.uiColor)
    private let valueLabel = UILabel.buildStyle(size: .bodyOne, weight: .bold, textColor: Colors.offBlack.uiColor)
    
    init(title: String, value: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        valueLabel.text = value
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemView: ViewConfiguration {
    func configViews() {
        axis = .vertical
        spacing = 4
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buildViews() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
    }
    
    func setupConstraints() {}
}
