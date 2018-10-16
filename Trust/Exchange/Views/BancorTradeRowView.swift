// Copyright DApps Platform Inc. All rights reserved.

import UIKit

enum BancorTradeRowType {
    case send
    case receive
}

protocol BancorTradeRowViewProtocol: class {
    func cionSelectClick(in row: BancorTradeRowView)
}

class BancorTradeRowView: UIView {
    
    var type: BancorTradeRowType = .send {
        willSet {
            
        }
        didSet {
            switch type {
            case .send:
                textfield.placeholder = "输入金额"
            case .receive:
                
                textfield.placeholder = nil
                //                textfield.ed
                
                walletImageView.image = nil
                walletNotationLabel.text  = nil
                walletBalanceLabel.text   = nil
                
                notaionLabel.text = "接受"
            }
        }
    }
    
    var delegate: BancorTradeRowViewProtocol?
    
    // left
    var notaionLabel: UILabel!
    var textfield: UITextField!
    var line: UIView!
    var convertLabel: UILabel!
    
    // right
    var walletNotationLabel: UILabel!
    var walletImageView: UIImageView!
    var walletBalanceLabel: UILabel!
    
    var coinSelectControl: BancorCoinSelectControl!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        walletImageView = UIImageView(image: UIImage(named: "icon_pruse"))
        addSubview(walletImageView)
        walletImageView.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: 15.0, height: 12.5))
            
        }
        walletNotationLabel = UILabel()
        walletNotationLabel.text = "剩余:"
        walletNotationLabel.font = UIFont.systemFont(ofSize: 14)
        walletNotationLabel.textAlignment = .right
        walletNotationLabel.textColor = Colors.bancorBlue
        addSubview(walletNotationLabel)
        walletNotationLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(walletImageView.snp.leading).offset(-2)
            make.centerY.equalTo(walletImageView)
        }
        walletBalanceLabel = UILabel()
        walletBalanceLabel.font = UIFont.systemFont(ofSize: 14)
        walletBalanceLabel.textColor = Colors.bancorBlue
        walletBalanceLabel.text = "0.01 CHX"
        walletBalanceLabel.textAlignment = .right
        
        notaionLabel = UILabel()
        notaionLabel.text = "支付"
        notaionLabel.textAlignment = .left
        notaionLabel.textColor = Colors.bancorNavigationBlack
        notaionLabel.font = UIFont.systemFont(ofSize: 15.0)
        
        
        let topStack = UIStackView(arrangedSubviews: [
            notaionLabel,
            walletBalanceLabel
            ])
        topStack.axis = .horizontal
        topStack.distribution = .fill
        addSubview(topStack)
        topStack.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(walletImageView.snp.bottom).offset(2)
        }
        
        
        textfield = UITextField()
        textfield.delegate = self
        textfield.font = UIFont.systemFont(ofSize: 12)
        
        coinSelectControl = BancorCoinSelectControl()
        coinSelectControl.addTarget(self, action: #selector(coinSelectControlAction), for: .touchUpInside)
        //        coinSelectControl.updateFrame()
        textfield.rightView = coinSelectControl
        textfield.rightViewMode = .always
        textfield.keyboardType = .decimalPad
        textfield.layoutIfNeeded()
        let bottomStack = UIStackView(arrangedSubviews: [
            textfield,
            //            coinSelectControl,
            ])
        bottomStack.axis = .horizontal
        //         bottomStack.distribution = .equalSpacing
        bottomStack.distribution = .fill
        //         bottomStack.spacing = 4
        //         bottomStack.alignment = .center
        
        
        addSubview(bottomStack)
        bottomStack.snp.makeConstraints { (make) in
            make.top.equalTo(topStack.snp.bottom).offset(4)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(30)
        }
        
        line = UIView()
        line.backgroundColor = Colors.bancorLineGrey
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
            make.top.equalTo(bottomStack.snp.bottom)
        }
        convertLabel = UILabel()
        convertLabel.text = "~$00.0200242"
        convertLabel.textColor = Colors.bancorBlue
        convertLabel.font = UIFont.systemFont(ofSize: 12.0)
        convertLabel.textAlignment = .left
        addSubview(convertLabel)
        convertLabel.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(line.snp.bottom)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coinSelectControl.updateFrame()
    }
    
    @objc func coinSelectControlAction() {
        if let delegate = self.delegate {
            delegate.cionSelectClick(in: self)
        }
    }
    
}

extension BancorTradeRowView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if type == .send {
            return true
        }else {
            return true
        }
    }
}
