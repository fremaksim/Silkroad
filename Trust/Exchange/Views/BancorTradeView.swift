// Copyright DApps Platform Inc. All rights reserved.

import UIKit

protocol BancorTradeViewProtocol: class {
    func cionSelectClick(in row: BancorTradeRowView)
}

class BancorTradeView: UIView {
    
    var delegate: BancorTradeViewProtocol?
    
    var topRowTradeView: BancorTradeRowView!
    var arrowImageView: UIImageView!
    var bottomRowTradeView: BancorTradeRowView!
    
    var rateNotationLabel: UILabel!
    var rateValueLabel: UILabel!
    var priceChangeTipButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topRowTradeView = BancorTradeRowView()
        topRowTradeView.delegate = self
        topRowTradeView.type = .send
        addSubview(topRowTradeView)
        topRowTradeView.snp.makeConstraints { (make) in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(92)
        }
        
        arrowImageView = UIImageView(image: UIImage(named: "down"))
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topRowTradeView.snp.bottom).offset(2)
            make.size.equalTo(CGSize(width: 10, height: 12.5))
            make.leading.equalToSuperview()
        }
        
        bottomRowTradeView = BancorTradeRowView()
        bottomRowTradeView.delegate = self
        bottomRowTradeView.type = .receive
        addSubview(bottomRowTradeView)
        bottomRowTradeView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(arrowImageView.snp.bottom).offset(2)
            make.height.equalTo(92)
        }
        
        rateNotationLabel = UILabel()
        rateNotationLabel.textAlignment = .left
        rateNotationLabel.text = "汇率"
        rateNotationLabel.font = UIFont.systemFont(ofSize: 15)
        rateNotationLabel.textColor = Colors.bancorNavigationBlack
        
        rateValueLabel = UILabel()
        rateValueLabel.text = "$0.0011"
        rateValueLabel.textColor = Colors.bancorTextLightGrey
        rateValueLabel.textAlignment = .right
        rateValueLabel.font = UIFont.systemFont(ofSize: 12)
        
        let rateStack = UIStackView(arrangedSubviews: [
            rateNotationLabel,
            rateValueLabel
            ])
        rateStack.axis = .horizontal
        rateStack.distribution = .fill
        
        addSubview(rateStack)
        rateStack.snp.makeConstraints { (make) in
            make.top.equalTo(bottomRowTradeView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        priceChangeTipButton = UIButton(type: .custom)
        priceChangeTipButton.setTitle("价格波动  ", for: .normal)
        priceChangeTipButton.setTitleColor(Colors.bancorNavigationBlack, for: .normal)
        priceChangeTipButton.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        priceChangeTipButton.setImage(UIImage(named: "icon_tip"), for: .normal)
        addSubview(priceChangeTipButton)
        priceChangeTipButton.snp.makeConstraints { (make) in
            make.top.equalTo(rateStack.snp.bottom).offset(10)
            make.leading.equalToSuperview()
        }
        priceChangeTipButton.imageOnRight()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BancorTradeView: BancorTradeRowViewProtocol {
    
    func cionSelectClick(in row: BancorTradeRowView) {
        if let delegate = self.delegate {
            delegate.cionSelectClick(in: row)
        }
    }
    
}
