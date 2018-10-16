
// Copyright DApps Platform Inc. All rights reserved.

import UIKit

private enum DetailLabelType: Int {
    case change24 = 240
    case priceUSD
    case volume24
    case liquidityDepth
}

class BancoreDetailView: UIView {
    
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .yellow
        view.layer.cornerRadius = 51.5
        view.layer.masksToBounds = true
        return view
    }()
    
    private let containerForIconImage = UIView()
    
    private var names: [String] = ["24H CHANGE","PRICE USD","24H VOLUME", "LIQUIDITY DEPTH"] // ["24小时涨幅",“美元单价”,"24小时变化","流动性深度"]
    
    var testValues = ["+1.98%","$0.0013","$9.0","$24123"]
    lazy var codelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = Colors.bancorTextLightGrey
         label.text = "BNT"
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = Colors.bancorTextLightGrey
        label.text = "Bancor"
        return label
    }()
    
    var change24hLabel: UILabel!
    var priceLabel: UILabel!
    var volumeLabel: UILabel!
    var liquidityDepth: UILabel!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerForIconImage.translatesAutoresizingMaskIntoConstraints = false
        containerForIconImage.addSubview(iconImageView)
        
        let nameStack = UIStackView(arrangedSubviews: [codelLabel,nameLabel])
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        nameStack.axis      = .vertical
        nameStack.alignment = .center
        nameStack.distribution = .equalSpacing
        nameStack.spacing   = 4
        
        let topStack = UIStackView(arrangedSubviews: [
            containerForIconImage,
            nameStack
            ])
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.axis = .vertical
        topStack.spacing = 1
        topStack.distribution = .equalSpacing
        
        
        var leftLabels: [UILabel] = []
        var rightLabels: [UILabel] = []
        for (i,name) in names.enumerated() {
            let leftLabel = UILabel()
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            leftLabel.textColor = Colors.bancorTextLightGrey
            leftLabel.font = UIFont.systemFont(ofSize: 15)
            leftLabel.textAlignment = .left
            leftLabel.text = name
            leftLabels.append(leftLabel)
            
            let rightLabel = UILabel()
            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            rightLabel.textColor = Colors.bancorTextLightGrey
            rightLabel.textAlignment = .right
            rightLabel.font = UIFont.systemFont(ofSize: 15)
//            rightLabel.text = testValues[i]
            rightLabel.tag = DetailLabelType.change24.rawValue + i
            rightLabels.append(rightLabel)
            
        }
        
        let leftStack = UIStackView(arrangedSubviews: leftLabels)
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.axis = .vertical
        leftStack.spacing = 4
        leftStack.distribution = .equalSpacing
    
    
        let rightStack = UIStackView(arrangedSubviews: rightLabels)
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        rightStack.axis = .vertical
        rightStack.spacing = 4
        rightStack.distribution = .equalSpacing
        
        let placeHolderView = UIView()
        placeHolderView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let bottmStack = UIStackView(arrangedSubviews: [leftStack,rightStack])
        bottmStack.translatesAutoresizingMaskIntoConstraints = false
        bottmStack.axis = .horizontal
        bottmStack.distribution = .fillEqually
        
        let stack = UIStackView(arrangedSubviews: [topStack,placeHolderView,bottmStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            containerForIconImage.topAnchor.constraint(equalTo: topAnchor),
            containerForIconImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerForIconImage.widthAnchor.constraint(equalToConstant: 103),
            containerForIconImage.heightAnchor.constraint(equalToConstant: 103),
            
            iconImageView.centerXAnchor.constraint(equalTo: containerForIconImage.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerForIconImage.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 103),
            iconImageView.heightAnchor.constraint(equalToConstant: 103),
            
             placeHolderView.leadingAnchor.constraint(equalTo: leadingAnchor),
             placeHolderView.trailingAnchor.constraint(equalTo: trailingAnchor),
             placeHolderView.heightAnchor.constraint(equalToConstant: 60),
            
            
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: BancorExchangeDetailViewModel) {
        iconImageView.kf.setImage(with: viewModel.imageURL, placeholder: UIImage(named: "exchangePlaceholder"), options: nil, progressBlock: nil, completionHandler: nil)
        
        
        change24hLabel = viewWithTag(DetailLabelType.change24.rawValue) as? UILabel
        priceLabel = viewWithTag(DetailLabelType.priceUSD.rawValue) as? UILabel
        volumeLabel = viewWithTag(DetailLabelType.volume24.rawValue) as? UILabel
        liquidityDepth = viewWithTag(DetailLabelType.liquidityDepth.rawValue) as? UILabel
        
        
        codelLabel.text = viewModel.code
        nameLabel.text = viewModel.name
        
        change24hLabel.text = viewModel.twoFourHour
        if viewModel.twoFourHour.hasPrefix("+") {
            change24hLabel.textColor = UIColor(red: 90, green: 185, blue: 62) //绿
        }else{
             change24hLabel.textColor = UIColor(red: 221, green: 49, blue: 49) //红
        }
        priceLabel.text = viewModel.priceUSD
        volumeLabel.text = viewModel.towFourVolume
        liquidityDepth.text = viewModel.liquidityDepth
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    
    }
    
}
