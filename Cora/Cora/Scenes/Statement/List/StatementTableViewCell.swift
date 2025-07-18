import DesignSystem
import UIKit

struct StatementItemViewModel {
    let value: String,
        description: String,
        receiver: String,
        time: String,
        icon: UIImage?
}

class StatementTableViewCell: UITableViewCell {
    private let valueLabel = UILabel.buildStyle(size: .bodyOne, weight: .regular, textColor: Colors.offBlack.uiColor)
    private let descriptionLabel = UILabel.buildStyle(size: .bodyTwo, weight: .regular, textColor: Colors.offBlack.uiColor)
    private let receiverLabel = UILabel.buildStyle(size: .bodyTwo, weight: .regular, textColor: Colors.grayOne.uiColor)
    private let timeLabel = UILabel.buildStyle(size: .caption, weight: .regular, textColor: Colors.grayOne.uiColor)
    private let iconImageView = UIImageView()
    
    private let infoContent = UIStackView()
    private let mainContent = UIStackView()
    
    func setupCell(with viewModel: StatementItemViewModel) {
        valueLabel.text = viewModel.value
        descriptionLabel.text = viewModel.description
        receiverLabel.text = viewModel.receiver
        timeLabel.text = viewModel.time
        iconImageView.image = viewModel.icon
        
        setupViews()
    }
}

extension StatementTableViewCell: ViewConfiguration {
    func configViews() {
        mainContent.alignment = .top
        mainContent.spacing = 16
        mainContent.translatesAutoresizingMaskIntoConstraints = false
        
        infoContent.axis = .vertical
        
        iconImageView.tintColor = Colors.offBlack.uiColor
        
        selectionStyle = .none
    }
    
    func buildViews() {
        contentView.addSubview(mainContent)
        
        [valueLabel,
         descriptionLabel,
         receiverLabel].forEach(infoContent.addArrangedSubview)
        
        [iconImageView,
         infoContent,
         timeLabel].forEach(mainContent.addArrangedSubview)
    }
    
    func setupConstraints() {
        let bottomConstraint = mainContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        bottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            timeLabel.widthAnchor.constraint(equalToConstant: 32),
            timeLabel.heightAnchor.constraint(equalToConstant: 32),
            
            mainContent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            bottomConstraint,
            mainContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
}
