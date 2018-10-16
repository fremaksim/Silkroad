// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import StackViewController

// reference TransactionViewController
class BancorConfirmConvertViewController: BancorBaseViewController {
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("确认", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = Colors.bancorBlue
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    
    let stackViewController = StackViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "确认支付"
        view.backgroundColor = Colors.bancorLightGrey
        

        let header = BancorConfirmConvertHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        
        let headerViewModel = BancorConfirmConvertHeaderViewViewModel(amountString: "-0.332 ETH",
                                                                      amountTextColor: Colors.bancorRed,
                                                                      monetaryAmountString: "(US$ 2.33)",
                                                                      statusImage: R.image.exchangePlaceholder())
        
        header.configure(for: headerViewModel)
        
        let dividerColor = Colors.bancorLineGrey
        let dividerOffset = UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        
        stackViewController.scrollView.alwaysBounceVertical = true
        stackViewController.stackView.spacing = TransactionAppearance.spacing
        

        
        let items: [UIView] = [
            .spacer(),
            header,
            TransactionAppearance.divider(color: dividerColor, alpha: 1, layoutInsets: dividerOffset),
            item(title: "支出地址", value: "0x34243242424242424"),
            TransactionAppearance.divider(color: dividerColor, alpha: 1, layoutInsets: dividerOffset),
            item(title: "Dapp", value: "0x23423424", subTitleMinimumScaleFactor: 1),
            TransactionAppearance.divider(color: dividerColor, alpha: 1, layoutInsets: dividerOffset),
//            item(title: "网络费用", value: "0.011ETH"),
            gasFeeTotalItem(),
//            TransactionAppearance.divider(color: dividerColor, alpha: 1),
            totalItem()
            
            ]
        
        for item in items {
            stackViewController.addItem(item)
        }
        stackViewController.stackView.preservesSuperviewLayoutMargins = true
        
        displayChildViewController(viewController: stackViewController)
        
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 49.0)
            ])
        
        
    }
    // MARK: -- Event Actions
    
   @objc private func nextButtonAction(){
        
        navigationController?.pushViewController(BancorConvertResultViewController(), animated: true)
    }
    
    // MARK: -- Private Methods
    private func item(title: String,
                      value: String,
                      subTitleMinimumScaleFactor: CGFloat  = 0.7) -> UIView {
        return  TransactionAppearance.item(
            title: title,
            subTitle: value,
            subTitleMinimumScaleFactor: subTitleMinimumScaleFactor
        ) { [weak self] in
            self?.showAlertSheet(title: $0, value: $1, sourceView: $2)
        }
    }
    
    private func gasFeeTotalItem() -> UIStackView {
        
        let gasFeeLabel = UILabel()
        gasFeeLabel.translatesAutoresizingMaskIntoConstraints = false
        gasFeeLabel.text = "网络费用"
        gasFeeLabel.textAlignment = .left
        
        let gasFeeValueLabel = UILabel()
        gasFeeValueLabel.translatesAutoresizingMaskIntoConstraints = true
        gasFeeValueLabel.text = "0.002416967 ETH"
        gasFeeValueLabel.textAlignment = .right
        
        
        let gasStack = UIStackView(arrangedSubviews: [gasFeeLabel,gasFeeValueLabel])
        gasStack.translatesAutoresizingMaskIntoConstraints = false
        gasStack.axis = .horizontal
        gasStack.spacing = 6
        gasStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        gasStack.isLayoutMarginsRelativeArrangement = true
        return gasStack
        
//        let maxTotalLabel = UILabel()
//        maxTotalLabel.translatesAutoresizingMaskIntoConstraints = false
//        maxTotalLabel.text = "最大统计:"
//        maxTotalLabel.textAlignment = .left
//
//        let maxTotalValueLabel = UILabel()
//        maxTotalValueLabel.translatesAutoresizingMaskIntoConstraints = true
//        maxTotalValueLabel.text = "0.002416967 ETH"
//        maxTotalValueLabel.textAlignment = .right
//
//        let maxTotalStack = UIStackView(arrangedSubviews: [maxTotalLabel,maxTotalValueLabel])
//        maxTotalStack.translatesAutoresizingMaskIntoConstraints = false
//        maxTotalStack.axis = .horizontal
//        maxTotalStack.distribution = .fillProportionally
//        maxTotalStack.addBackground(color: Colors.bancorLineGrey)
        
        
//        let stackView = UIStackView(arrangedSubviews: [gasStack,maxTotalStack])
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.spacing = 6
//        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
//        stackView.isLayoutMarginsRelativeArrangement = true
//
//        return stackView
    }
    
    private func totalItem() -> UIStackView {
        
        let maxTotalLabel = UILabel()
        maxTotalLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTotalLabel.text = "最大统计:"
        maxTotalLabel.textAlignment = .left
        
        let maxTotalValueLabel = UILabel()
        maxTotalValueLabel.translatesAutoresizingMaskIntoConstraints = true
        maxTotalValueLabel.text = "0.002416967 ETH"
        maxTotalValueLabel.textAlignment = .right
        
        let maxTotalStack = UIStackView(arrangedSubviews: [maxTotalLabel,maxTotalValueLabel])
        maxTotalStack.translatesAutoresizingMaskIntoConstraints = false
        maxTotalStack.axis = .horizontal
        maxTotalStack.spacing = 6
        maxTotalStack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        maxTotalStack.isLayoutMarginsRelativeArrangement = true
        maxTotalStack.addBackground(color: Colors.bancorLineGrey)

        return maxTotalStack
    }
    
    
    
    func showAlertSheet(title: String, value: String, sourceView: UIView) {
        let alertController = UIAlertController(
            title: nil,
            message: value,
            preferredStyle: .actionSheet
        )
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView.bounds
        let copyAction = UIAlertAction(title: NSLocalizedString("Copy", value: "Copy", comment: ""), style: .default) { _ in
            UIPasteboard.general.string = value
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { _ in }
        alertController.addAction(copyAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
}
