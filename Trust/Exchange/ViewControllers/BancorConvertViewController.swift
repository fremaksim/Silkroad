// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorConvertViewController: BancorBaseViewController {
    
    
    var convertView: BancorConvertView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "兑换代币"
        view.backgroundColor = Colors.bancorLightGrey
        
        convertView = BancorConvertView()
        convertView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(convertView)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 49.0)
            ])
        
        NSLayoutConstraint.activate([
            convertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: StyleLayout.sideCellMargin),
            convertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -StyleLayout.sideCellMargin),
            convertView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            convertView.heightAnchor.constraint(equalToConstant: CommonDevices.screenWidth - 2 * StyleLayout.sideCellMargin)
            ])
        
    }
    
    @objc private func nextButtonAction(){
        
        navigationController?.pushViewController(BancorConfirmConvertViewController(), animated: true)
    }
    
    
}
