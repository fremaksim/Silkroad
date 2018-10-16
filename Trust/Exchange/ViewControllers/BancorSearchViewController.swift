// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorSearchViewController: BancorBaseViewController {
    
    var viewModel: BancorSearchViewModel
    var exchanges: [BancorSearchExchange]?
    var collectionView: UICollectionView!
    
    init(viewModel: BancorSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.loadingAllExchanges { [weak self] (list, isSuccess) in
            self?.exchanges = list
            self?.collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = BancorSearchbarView()
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: BancorIconCollectionFlowLayout())
        collectionView.backgroundColor = Colors.bancorLightGrey
        collectionView.register(BancorIconCollectionViewCell.self, forCellWithReuseIdentifier: BancorIconCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: CommonDevices.navigationBarBottomMaxY),
            
            cancelButton.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -6),
            cancelButton.heightAnchor.constraint(equalToConstant: 31),
            cancelButton.widthAnchor.constraint(equalToConstant: 60),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: CommonDevices.navigationBarBottomMaxY),
            
            ])
        
    }
    
    // MARK: -- Event Actions
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension BancorSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exchanges?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BancorIconCollectionViewCell.identifier, for: indexPath) as! BancorIconCollectionViewCell
        let exchange = exchanges?[indexPath.item] ?? BancorSearchExchange()
        cell.configure(viewModel: BancorSearchExchangeCellViewModel(exchange: exchange))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
