
// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorIconCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BancorIconCollectionViewCell"
    
    private var iconImageView: UIImageView!
    private var codeLabel: UILabel!
    private var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconImageView = UIImageView()
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.masksToBounds = true
        iconImageView.image = R.image.exchangePlaceholder()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerForIcon = UIView()
        containerForIcon.translatesAutoresizingMaskIntoConstraints = false
        containerForIcon.addSubview(iconImageView)
        
        let iconStack = UIStackView(arrangedSubviews: [containerForIcon])
        iconStack.translatesAutoresizingMaskIntoConstraints = false
        
        codeLabel = UILabel()
        codeLabel.text = "ETH"
        codeLabel.font = UIFont.systemFont(ofSize: 15)
        codeLabel.textColor = Colors.bancorTextLightGrey
        codeLabel.textAlignment = .center
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel = UILabel()
        nameLabel.text = "Ethereum"
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textAlignment = .center
        nameLabel.textColor = Colors.bancorTextLightGrey
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let placeholderLabel = UILabel()
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.text = " "
        placeholderLabel.font = UIFont.systemFont(ofSize: 12)
        placeholderLabel.textColor = Colors.bancorLightGrey
        
        let textStack = UIStackView(arrangedSubviews: [
            codeLabel,
            nameLabel,
            placeholderLabel
            ])
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.axis = .vertical
        textStack.distribution = .fillEqually
        
        
        let stack = UIStackView(arrangedSubviews: [
            iconStack,
            textStack
            ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            
            containerForIcon.centerXAnchor.constraint(equalTo: iconStack.centerXAnchor),
            containerForIcon.centerYAnchor.constraint(equalTo: iconStack.centerYAnchor),
            containerForIcon.widthAnchor.constraint(equalToConstant: 40),
            containerForIcon.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.centerXAnchor.constraint(equalTo: containerForIcon.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerForIcon.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(viewModel: BancorSearchExchangeCellViewModel) {
        
        iconImageView.kf.setImage(with: viewModel.imageURL,
                                  placeholder: R.image.exchangePlaceholder(),
                                  options: nil,
                                  progressBlock: nil,
                                  completionHandler: nil)
        codeLabel.text = viewModel.code
        nameLabel.text = viewModel.name
        
    }
    
}
