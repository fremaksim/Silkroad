// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorExchangeDetailViewController: BancorBaseViewController {
    
    var viewModel: BancorExchangeDetailViewModel
    
    lazy var detailVeiw: BancoreDetailView = {
        let view = BancoreDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buyButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("买入", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        btn.backgroundColor = Colors.BancorGreen
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var sellButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("卖出", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        btn.backgroundColor = Colors.bancorRed
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(sellButtonAction), for: .touchUpInside)
        return btn
    }()
    
    init(viewModel: BancorExchangeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
        
        let stackView = UIStackView(arrangedSubviews: [
            buyButton,
            sellButton
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 49.0)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 买入
    @objc private func buyButtonAction(){
        let vc = BancorTransactionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //卖出
    @objc private func sellButtonAction(){
        let vc = BancorTransactionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title  =  (viewModel.exchange.code ?? "Token") + "详情"
        view.backgroundColor = Colors.bancorLightGrey
        
        view.addSubview(detailVeiw)
        
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        
        NSLayoutConstraint.activate([
            detailVeiw.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor, constant: 96),
            detailVeiw.widthAnchor.constraint(equalToConstant: screenWidth - 44.0),
            detailVeiw.heightAnchor.constraint(equalToConstant: screenWidth - 44.0),
            detailVeiw.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            ])
        
        detailVeiw.configure(viewModel: viewModel)
    }

}
