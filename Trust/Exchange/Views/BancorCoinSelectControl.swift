// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorCoinSelectControl: UIControl {

    var coinImageView: UIImageView!
    var coinCodeLabel: UILabel!
    var arrowImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        arrowImageView = UIImageView(image: UIImage(named: "icon_down"))
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 13, height: 13))
            make.centerY.trailing.equalToSuperview()
        }
 
        
        coinImageView = UIImageView()
        coinImageView.image = UIImage(named: "exchangePlaceholder")
        coinImageView.layer.cornerRadius = 10.5
        coinImageView.layer.masksToBounds = true
        addSubview(coinImageView)
        coinImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 21, height: 21))
            make.centerY.leading.equalToSuperview()
//            make.trailing.equalTo(coinCodeLabel.snp.leading).offset(-2)
        }
        
        coinCodeLabel = UILabel()
        coinCodeLabel.text = "BNT"
        coinCodeLabel.textAlignment = .center
        coinCodeLabel.textColor = Colors.bancorNavigationBlack
        coinCodeLabel.font = UIFont.systemFont(ofSize: 12)
        //        coinCodeLabel.adjustsFontSizeToFitWidth = true
        //        coinCodeLabel.minimumScaleFactor = 0.9
        addSubview(coinCodeLabel)
        coinCodeLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-2)
            make.leading.equalTo(coinImageView.snp.trailing).offset(2)
            //            make.leading.equalToSuperview().offset(21 + 2)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame() {
        let height: CGFloat = self.frame.height > 0 ? self.frame.height : 30.0
     let labelWidth = coinCodeLabel.text!.width(withConstrainedHeight: height, font: UIFont.systemFont(ofSize: 12))
        
     self.frame =  CGRect(x: 0, y: 0, width: 38 + labelWidth, height: height)
        
        layoutIfNeeded()
    
    }
    
    
}
