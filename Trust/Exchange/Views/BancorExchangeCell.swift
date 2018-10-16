// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import Kingfisher

final class BancorExchangeCell: UITableViewCell {
    static let identifier = "BancorExchangeCell"
    
    let iconImageView = BancorImageView()
    let codeLabel  = UILabel()
    let nameLabel  = UILabel()
    let priceLabel = UILabel()
    
    let containerForImageView = UIView()
    
    // 涨幅 
    let indicatorView = BancorIndicatorLabel()
    let containerForIndicatorView = UIView()
    
    lazy var greyView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.bancorLightGrey
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        codeLabel.textColor = Colors.bancorTextLightGrey
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.textAlignment = .left
        codeLabel.font = UIFont.systemFont(ofSize: 15.0)
        
        nameLabel.textColor = Colors.bancorTextLightGrey
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .left
        nameLabel.lineBreakMode = .byTruncatingMiddle
        nameLabel.font = UIFont.systemFont(ofSize: 10.0)
        
        priceLabel.textColor = Colors.bancorTextLightGrey
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerForImageView.translatesAutoresizingMaskIntoConstraints = false
        containerForImageView.addSubview(iconImageView)
        
        let nameStack = UIStackView(arrangedSubviews:[codeLabel,nameLabel])
        nameStack.translatesAutoresizingMaskIntoConstraints  = false
        nameStack.axis = .vertical
        nameStack.spacing = 8
        nameStack.alignment = .leading
        
        let leftStack = UIStackView(arrangedSubviews: [containerForImageView,nameStack])
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.axis = .horizontal
        leftStack.alignment = .firstBaseline
        leftStack.distribution = .fillEqually
        
        containerForIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        containerForIndicatorView.addSubview(indicatorView)
        
        let stackView = UIStackView(arrangedSubviews: [leftStack,priceLabel,containerForIndicatorView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        contentView.addSubview(stackView)
        
        contentView.addSubview(greyView)
        
        NSLayoutConstraint.activate([
            containerForImageView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            containerForImageView.widthAnchor.constraint(equalToConstant: BancorLayout.cell.imageSize),
            containerForImageView.heightAnchor.constraint(equalToConstant: BancorLayout.cell.imageSize),
            iconImageView.leadingAnchor.constraint(equalTo: containerForImageView.leadingAnchor, constant: BancorLayout.cell.stackVericalOffset),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: BancorLayout.cell.imageSize),
            iconImageView.heightAnchor.constraint(equalToConstant: BancorLayout.cell.imageSize),

            indicatorView.centerXAnchor.constraint(equalTo: containerForIndicatorView.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: containerForIndicatorView.centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: BancorLayout.cell.indicatorViewSize.width),
            indicatorView.heightAnchor.constraint(equalToConstant: BancorLayout.cell.indicatorViewSize.height),
            
            stackView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -BancorLayout.cell.seperatorLineHeight),
            
            greyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            greyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            greyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            greyView.topAnchor.constraint(equalTo: stackView.bottomAnchor)
            ])
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: BancorExchangeCellViewModel) {
        
        KingfisherManager.shared.downloader.downloadTimeout = 30
//        iconImageView.kf.indicatorType = .activity
        iconImageView.kf.setImage(with: viewModel.imageURL, placeholder: UIImage(named: "exchangePlaceholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
        codeLabel.text = viewModel.code
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.priceUSD
        
        indicatorView.configure(viewModel: BancorIndicatorViewModel(viewModel: viewModel))
        
    }
}

