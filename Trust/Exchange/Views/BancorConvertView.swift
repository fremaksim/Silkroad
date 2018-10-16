// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorConvertView: UIView {
    
    var fromCoinButton: CenteredButton!
    var toCoinButton: CenteredButton!
    var arrowImageView: UIImageView!
    
    var rateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderColor = Colors.bancorLineGrey.cgColor
        layer.borderWidth = 0.5
        layer.masksToBounds = true
        
        fromCoinButton = CenteredButton(type: .custom) //46 * 46
        fromCoinButton.translatesAutoresizingMaskIntoConstraints = false
        fromCoinButton.setImage(R.image.exchangePlaceholder(), for: .normal)
        fromCoinButton.setTitle("ETH", for: .normal)
        fromCoinButton.setTitleColor(Colors.bancorBlue, for: .normal)
        fromCoinButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        arrowImageView = UIImageView(image: R.image.arrowRight())
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let containverForArrow = UIView()
        containverForArrow.translatesAutoresizingMaskIntoConstraints = false
        containverForArrow.addSubview(arrowImageView)
        
        
        toCoinButton = CenteredButton(type: .custom) //46 * 46
        toCoinButton.translatesAutoresizingMaskIntoConstraints = false
        toCoinButton.setImage(R.image.exchangePlaceholder(), for: .normal)
        toCoinButton.setTitle("ETH", for: .normal)
        toCoinButton.setTitleColor(Colors.bancorBlue, for: .normal)
        toCoinButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let topStack = UIStackView(arrangedSubviews: [
            fromCoinButton,
            containverForArrow,
            toCoinButton,
            ])
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.axis = .horizontal
        topStack.distribution = .fillEqually
        
        // 收到 支出
        let outLabel = UILabel()
        outLabel.text = "支出"
        outLabel.translatesAutoresizingMaskIntoConstraints = false
        outLabel.textAlignment = .left
        outLabel.font = UIFont.systemFont(ofSize: 15)
        outLabel.textColor = Colors.bancorNavigationBlack
        
        let outValueLabel = UILabel()
        outValueLabel.text = "0.01ETH"
        outValueLabel.translatesAutoresizingMaskIntoConstraints = false
        outValueLabel.textAlignment = .right
        outValueLabel.font = UIFont.systemFont(ofSize: 15)
        outValueLabel.textColor = Colors.bancorTextLightGrey
        
        let outStack = UIStackView(arrangedSubviews: [
            outLabel,
            outValueLabel,
        ])
        outStack.translatesAutoresizingMaskIntoConstraints = false
        outStack.axis = .horizontal
        outStack.distribution = .fillProportionally
        
        let receiveLabel = UILabel()
        receiveLabel.text = "收到"
        receiveLabel.translatesAutoresizingMaskIntoConstraints = false
        receiveLabel.textAlignment = .left
        receiveLabel.font = UIFont.systemFont(ofSize: 15)
        receiveLabel.textColor = Colors.bancorNavigationBlack
        
        let receiveValueLabel = UILabel()
        receiveValueLabel.text = "1.524BNT"
        receiveValueLabel.translatesAutoresizingMaskIntoConstraints = false
        receiveValueLabel.textAlignment = .right
        receiveValueLabel.font = UIFont.systemFont(ofSize: 15)
        receiveValueLabel.textColor = Colors.bancorTextLightGrey
        
        let receiveStack = UIStackView(arrangedSubviews: [
            receiveLabel,
            receiveValueLabel,
            ])
        receiveStack.translatesAutoresizingMaskIntoConstraints = false
        receiveStack.axis = .horizontal
        outStack.distribution = .fillProportionally
        
        let middleStack = UIStackView(arrangedSubviews: [
            outStack,
            receiveStack
            ])
        middleStack.translatesAutoresizingMaskIntoConstraints = false
        middleStack.axis = .vertical
        middleStack.distribution = .fillEqually
        
        // 矿工交易费
        let mineFeeMaxButton = UIButton(type: .custom)
        mineFeeMaxButton.translatesAutoresizingMaskIntoConstraints = false
//        mineFeeMaxButton.contentMode = .left
        mineFeeMaxButton.setTitle("最大交易矿工费  ", for: .normal)
        mineFeeMaxButton.setTitleColor(Colors.bancorNavigationBlack, for: .normal)
        mineFeeMaxButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        mineFeeMaxButton.setImage(R.image.icon_tip(), for: .normal)
//        mineFeeMaxButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -14)
        mineFeeMaxButton.imageOnRight()
        mineFeeMaxButton.setContentHuggingPriority(.required, for: .horizontal)
        mineFeeMaxButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let mineFeeLabel = UILabel()
        mineFeeLabel.text = "0.00013ETH"
        mineFeeLabel.translatesAutoresizingMaskIntoConstraints = false
        mineFeeLabel.textColor = Colors.bancorTextLightGrey
        mineFeeLabel.font = UIFont.systemFont(ofSize: 15)
        mineFeeLabel.textAlignment = .right
        
        let bottomStack = UIStackView(arrangedSubviews: [
            mineFeeMaxButton,
            mineFeeLabel
            ])
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.axis = .horizontal
        bottomStack.distribution = .fillProportionally
        
        let stack = UIStackView(arrangedSubviews: [
            topStack,
            middleStack,
            bottomStack
            ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        addSubview(stack)
        
        // 加线
        let topLine = UIView()
        topLine.backgroundColor = Colors.bancorLineGrey
        topLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topLine)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = Colors.bancorLineGrey
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomLine)
        
        // 以太币汇率 label
        rateLabel = UILabel()
        rateLabel.text = "  1 ETH = 152.334344 BNT  "
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.textColor = Colors.bancorTextLightGrey
        rateLabel.backgroundColor = Colors.bancorLineGrey
        rateLabel.font = UIFont.systemFont(ofSize: 14.0)
        rateLabel.textAlignment = .center
        rateLabel.sizeToFit()
        addSubview(rateLabel)
        
        // 布局
        let margin: CGFloat = 10.0
        NSLayoutConstraint.activate([
            
            containverForArrow.centerXAnchor.constraint(equalTo: topStack.centerXAnchor),
            containverForArrow.centerYAnchor.constraint(equalTo: topStack.centerYAnchor),
            containverForArrow.widthAnchor.constraint(equalToConstant: 25),
            containverForArrow.heightAnchor.constraint(equalToConstant: 20.0),
            
            arrowImageView.centerXAnchor.constraint(equalTo: containverForArrow.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: containverForArrow.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 25),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20.0),
            
            topLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 0.5),
            topLine.bottomAnchor.constraint(equalTo: topStack.bottomAnchor),
            
            
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 0.5),
            bottomLine.bottomAnchor.constraint(equalTo: middleStack.bottomAnchor, constant: 8),
            
            rateLabel.centerXAnchor.constraint(equalTo: bottomLine.centerXAnchor),
            rateLabel.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor),
            rateLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
