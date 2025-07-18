import DesignSystem
import UIKit

class StatementHeaderView: UIView {
    private let titleLabel = UILabel.buildStyle(size: .caption, weight: .regular, textColor: Colors.grayOne.uiColor)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setupHeader(with title: String) {
        titleLabel.text = title
    }
}

extension StatementHeaderView: ViewConfiguration {
    func configViews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.grayFour.uiColor
    }
    
    func buildViews() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
