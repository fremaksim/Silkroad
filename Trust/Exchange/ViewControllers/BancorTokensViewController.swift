// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import MJRefresh

class BancorTokensViewController: UIViewController {
    fileprivate var viewModel: BancorTokensViewModel
    lazy var header: BancorExchangeHeaderView = {
        let header = BancorExchangeHeaderView(frame: .zero)
        //        header.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: 40)
        return header
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.bancorLightGrey
        tableView.rowHeight = viewModel.cellHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BancorExchangeCell.self, forCellReuseIdentifier: BancorExchangeCell.identifier)
        //        tableView.tableHeaderView = header
        //        tableView.addSubview(refreshControl)
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.viewModel.fetchFirstPage()
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            [weak self] in
            self?.viewModel.fetchNextPage()
        })
        return tableView
    }()
    let refreshControl = UIRefreshControl()
    init(viewModel: BancorTokensViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getGroupExchanges()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        viewModel.callBack = { (_, _) in
            
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
    }
}


extension BancorTokensViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BancorExchangeCell.identifier, for: indexPath) as! BancorExchangeCell
        cell.configure(viewModel: viewModel.cellViewModel(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = BancorExchangeDetailViewController(viewModel: viewModel.detailViewModel(for: indexPath))
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
