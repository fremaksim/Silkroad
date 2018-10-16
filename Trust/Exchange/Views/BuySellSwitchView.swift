// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BuySellSwitchView: UIView { // 214 * 37
    
    var buyButton: UIButton!
    var sellButton: UIButton!
    var line: UIView! // 108 * 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buyButton = UIButton(type: .custom)
        buyButton.setTitle("买入", for: .normal)
        buyButton.setTitleColor(Colors.bancorNavigationBlack, for: .selected)
        buyButton.setTitleColor(Colors.bancorTextLightLightGrey, for: .normal)
        buyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        buyButton.isSelected = true
        buyButton.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
        
        sellButton = UIButton(type: .custom)
        sellButton.setTitle("卖出", for: .normal)
        sellButton.setTitleColor(Colors.bancorNavigationBlack, for: .selected)
        sellButton.setTitleColor(Colors.bancorTextLightLightGrey, for: .normal)
        sellButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        sellButton.addTarget(self, action: #selector(sellButtonAction), for: .touchUpInside)
        let stackView = UIStackView(arrangedSubviews: [
            buyButton,sellButton
            ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        line = UIView()
        line.backgroundColor = Colors.bancorNavigationBlack
        addSubview(line)
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        line.snp.makeConstraints { (make) in
            make.bottom.leading.equalTo(0)
            make.width.equalTo(CommonDevices.screenWidth * 0.5)
            make.height.equalTo(3)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -- events methods
    @objc func buyButtonAction(btn: UIButton) {
        line.snp.updateConstraints { (make) in
            make.leading.equalTo(0)
        }
        btn.isSelected = true
        
        sellButton.isSelected = !btn.isSelected
    }
    
    @objc func sellButtonAction(btn: UIButton) {
        line.snp.updateConstraints { (make) in
            make.leading.equalTo(CommonDevices.screenWidth * 0.5)
        }
        btn.isSelected = true
        
        buyButton.isSelected = !btn.isSelected
        
        
    }
    
    
}
