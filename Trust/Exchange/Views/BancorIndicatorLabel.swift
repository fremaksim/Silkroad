// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

final class BancorIndicatorLabel: UIView {
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
    
//        clipsToBounds = false
       
        
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rateLabel)
        
        NSLayoutConstraint.activate([
            rateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rateLabel.topAnchor.constraint(equalTo: topAnchor),
            rateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    }
    
    func showRedBackground() {
        backgroundColor = UIColor(red: 221, green: 49, blue: 49)
    }
    
    func showGreenBackground() {
        backgroundColor = UIColor(red: 90, green: 185, blue: 62)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: BancorIndicatorViewModel) {
        if viewModel.showAddStyle() {
            showGreenBackground()
        }else{
            showRedBackground()
        }
        rateLabel.text = viewModel.twoFourHourChange()
    }
    
}
