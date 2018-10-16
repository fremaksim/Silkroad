// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

final class BancorExchangeHeaderView: UIView {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "名称"
        label.textColor = Colors.black
        label.textAlignment = .center
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "价格"
        label.textColor = Colors.black
        label.textAlignment = .center
        return label
    }()
    
    lazy var _24hChangeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "24小时涨幅"
        label.textColor = Colors.black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.bancorLightGrey
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        _24hChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            priceLabel,
            _24hChangeLabel
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
