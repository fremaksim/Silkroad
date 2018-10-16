// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit

class BancorTransactionViewController: UIViewController {
    
    private var backItemTitle: String? = ""
    
    lazy var segment: BuySellSwitchView = {
        let view =  BuySellSwitchView()
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("下一步", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = Colors.bancorBlue
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    var tradeView: BancorTradeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.bancorLightGrey
        
        self.view.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.top.equalTo(CommonDevices.navigationBarBottomMaxY)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(44.0)
        }
        
        tradeView = BancorTradeView(frame: .zero)
        tradeView.delegate = self
        view.addSubview(tradeView)
        tradeView.snp.makeConstraints { (make) in
            make.top.equalTo(segment.snp.bottom).offset(20)
            make.leading.equalTo(21)
            make.trailing.equalTo(-21)
            make.height.equalTo(272.5)
        }
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 49.0)
            ])
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
        
    }
    
    
    // MARK: -- Event Actions
    @objc func nextButtonAction() {
        
        navigationController?.pushViewController(BancorConvertViewController(), animated: true)
    }
    
}


extension BancorTransactionViewController: BancorTradeViewProtocol {
    func cionSelectClick(in row: BancorTradeRowView) {
        let viewModel = BancorSearchViewModel()
        let searchVc = BancorSearchViewController(viewModel: viewModel)
        present(searchVc, animated: true, completion: nil)
    }
    
    
}
