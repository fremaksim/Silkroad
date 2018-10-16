// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorConvertResultViewController: BancorBaseViewController {
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("返回首页", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = Colors.bancorBlue
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "兑换结算"
        view.backgroundColor = Colors.bancorLightGrey
        
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 49.0)
            ])
        
    }
    
    // MARK: -- Event Actions
    @objc func nextButtonAction() {
        
    }
    
}
