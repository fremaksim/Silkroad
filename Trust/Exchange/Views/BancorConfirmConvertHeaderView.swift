// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Foundation

struct BancorConfirmConvertHeaderAppereance {
    static let amountFont = UIFont.systemFont(ofSize: 18.0)
    //货币字体
    static let monetaryFont = UIFont.systemFont(ofSize: 13, weight: .light)
    //货币textColor
    static let monetaryTextColor = TokensLayout.cell.fiatAmountTextColor
}

struct BancorConfirmConvertHeaderViewViewModel {
    let amountString: String
    let amountTextColor: UIColor
    let monetaryAmountString: String?
    let statusImage: UIImage?
}

class BancorConfirmConvertHeaderView: UIView {

    let imageView = UIImageView()
    let amountLabel = UILabel()
    let monetaryAmountLabel = UILabel()
    
    override init(frame: CGRect = .zero) {
        
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.textAlignment = .center
        amountLabel.font = BancorConfirmConvertHeaderAppereance.amountFont
        
        monetaryAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        monetaryAmountLabel.textAlignment = .center
        monetaryAmountLabel.font = BancorConfirmConvertHeaderAppereance.monetaryFont
        monetaryAmountLabel.textColor = BancorConfirmConvertHeaderAppereance.monetaryTextColor
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            .spacerWidth(),
            amountLabel,
            monetaryAmountLabel,
            ])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: StyleLayout.sideMargin),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -StyleLayout.sideMargin),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for viewModel: BancorConfirmConvertHeaderViewViewModel) {
        amountLabel.text = viewModel.amountString
        amountLabel.textColor = viewModel.amountTextColor
        monetaryAmountLabel.text = viewModel.monetaryAmountString
        imageView.image = viewModel.statusImage
    }
    
}
