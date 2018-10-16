// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import QRCodeReaderViewController


enum DetailsViewType: Int {
    case tokens
    case nonFungibleTokens
}

class WalletViewController: UIViewController {
    //    fileprivate var viewModel: TokensViewModel
    weak var delegate: TokensViewControllerDelegate?
    
    var preRightBarButton: UIBarButtonItem!
    
    fileprivate lazy var segmentController: UISegmentedControl = {
        let items = [
            R.string.localizable.tokens(),
            R.string.localizable.collectibles(),
            ]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = DetailsViewType.tokens.rawValue
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let selectedTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.blue]
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.setDividerImage(UIImage.filled(with: UIColor.white), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        for selectView in segmentedControl.subviews {
            selectView.tintColor = UIColor.white
        }
        return segmentedControl
    }()
    var tokensViewController: TokensViewController
    //    var nonFungibleTokensViewController: NonFungibleTokensViewController
    var bancorExchangeViewController: BancorTokensViewController
    //        viewModel: TokensViewModel
    init(
        tokensViewController: TokensViewController,
        //        nonFungibleTokensViewController: NonFungibleTokensViewController
        bancorExchangeViewController: BancorTokensViewController
        
        ) {
        self.tokensViewController = tokensViewController
        //        self.nonFungibleTokensViewController = nonFungibleTokensViewController
        self.bancorExchangeViewController = bancorExchangeViewController
        super.init(nibName: nil, bundle: nil)
    }
    //        self.viewModel = viewModel
    //    lazy var fetchClosure: () -> Void = {
    //        return debounce(delay: .seconds(7), action: { [weak self] () in
    //            self?.viewModel.fetch()
    //        })
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentController
        setupView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.browser_scan(), style: .done, target: self, action: #selector(openReader))
        
        
    }
    
    private func setupView() {
        self.preRightBarButton  =  self.navigationItem.rightBarButtonItem
        updateView()
    }
    
    private func updateView() {
        if segmentController.selectedSegmentIndex == DetailsViewType.tokens.rawValue { //点击通证
            showBarButtonItems()
            removeExchangeSearchIcon()
            //            remove(asChildViewController: nonFungibleTokensViewController)
            remove(asChildViewController: bancorExchangeViewController)
            add(asChildViewController: tokensViewController)
        } else { //点击兑换
            hideBarButtonItems()
            addExchangeSearchIcon()
            remove(asChildViewController: tokensViewController)
            //            add(asChildViewController: nonFungibleTokensViewController)
            
            add(asChildViewController: bancorExchangeViewController)
            
        }
    }
    
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    @objc func openReader() {
        let controller = QRCodeReaderViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    @objc func searchExchange(){
        present(BancorSearchViewController(viewModel: BancorSearchViewModel()), animated: true, completion: nil)
    }
    
    private func showBarButtonItems() {
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    private func hideBarButtonItems() {
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
//        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    private func addExchangeSearchIcon() {
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.icon_search(), style: .done, target: self, action: #selector(searchExchange))
    }
    
    private func removeExchangeSearchIcon() {
        self.navigationItem.rightBarButtonItem = self.preRightBarButton
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WalletViewController: Scrollable {
    func scrollOnTop() {
        switch segmentController.selectedSegmentIndex {
        case DetailsViewType.tokens.rawValue:
            tokensViewController.tableView.scrollOnTop()
        case DetailsViewType.nonFungibleTokens.rawValue:
            SRLog(message: "todo")
        //            nonFungibleTokensViewController.tableView.scrollOnTop()
        default:
            break
        }
    }
}
//修改扫描
extension WalletViewController: QRCodeReaderDelegate {
    func readerDidCancel(_ reader: QRCodeReaderViewController!) {
        reader.stopScanning()
        reader.dismiss(animated: true, completion: nil)
        print("扫描取消")
        //        fetchClosure()
        //        let token = viewModel.item(for: IndexPath(row: 0, section: 0))
        //        delegate?.didSelect(token: token, in: self)
    }
    func reader(_ reader: QRCodeReaderViewController!, didScanResult result: String!) {
        reader.stopScanning()
        //        setValueForCurrentField(string: result)
        NotificationCenter.default.post(name: Notification.Names.QRCodeReadAddress, object: nil, userInfo: ["result": result])
        reader.dismiss(animated: true)
        //        fetchClosure()
    }
}
