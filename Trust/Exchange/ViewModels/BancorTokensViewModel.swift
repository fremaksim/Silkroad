// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

final class BancorTokensViewModel {
    
    // 一次请求
    private var tokensRows: [BancorExchange] = []
    
    // 分页所有
    private var allTokenRows: [BancorExchange] = []
    
    private var rate: BancorRate = BancorRate()
    
    private var skip:  Int = 0
    private var limit: Int = 15
    
    var callBack: (([BancorExchange], BancorRate) -> Void)?
    
    var exchangeNetwork: BancorSubNetworkProtocol
    
    var headerBackgroundColor: UIColor {
        return UIColor(hex: "fafafa")
    }
    var headerHeight: CGFloat {
        return 49.0
    }
    
    var cellHeight: CGFloat {
        return 85.0 + BancorLayout.cell.seperatorLineHeight
    }
    
    var exchangesCallback: (([BancorExchange])-> Void)? 
    
    init(exchangeNetwork: BancorSubNetworkProtocol) {
        self.exchangeNetwork = exchangeNetwork
    }
    
    func getGroupExchanges() {
        // 1
        DispatchQueue.global(qos: .userInitiated).async {
            // 2
            let requestGroup = DispatchGroup()
            for i in 0...1 {
                // 3
                requestGroup.enter()
                if i == 0 {
                    self.exchangeNetwork.getRate(completion: { (rate) in
                        if let rate = rate {
                            self.update(rate: rate)
                        }
                        // 4
                        requestGroup.leave()
                    })
                }else{
                    self.exchangeNetwork.tokens(limit: self.limit, skip: self.skip, fromCurrencyCode: "ETH", includeTotal: false, orderBy: "liquidityDepth", sortOrder: "desc", minimalDataOnly: false , q: nil) { (result, isSuccess)  in
                        SRLog(message: result)
                        if let res = result, isSuccess {
                            self.update(exchanges: res)
                            self.exchangesCallback?(res)
                        }
                        // 4
                        requestGroup.leave()
                    }
                }
            }
            
            // 5
            requestGroup.wait()
            
            // 6
            DispatchQueue.main.async {
                self.reloadData()
            }
            
        }
    }
    
    func fetchFirstPage() {
        skip = 0
        
        getGroupExchanges()
    }
    
    func fetchNextPage() {
        if hasNextPage() {
            skip += limit
        }
        getGroupExchanges()
    }
    
    func hasNextPage() -> Bool {
        return  tokensRows.count == limit
    }
    
    func reloadData() {
        tokensRows  =  tokensRows.map { (exchange) -> BancorExchange in
            exchange.rate = rate
            return exchange
        }
        
        allTokenRows = allTokenRows.map{ (exchange) -> BancorExchange in
            exchange.rate = rate
            return exchange
        }
        
        if let callBack = self.callBack {
            callBack(tokensRows,rate)
        }
    }
    
    func getRate() {
        self.exchangeNetwork.getRate(completion: { (rate) in
            if let rate = rate {
                self.update(rate: rate)
            }
        })
    }
    
    func getExchanges() {
        exchangeNetwork.tokens(limit: 15, skip: 0, fromCurrencyCode: "ETH", includeTotal: false, orderBy: "liquidityDepth", sortOrder: "desc", minimalDataOnly: false , q: nil) { (result, isSuccess)  in
            SRLog(message: result)
            if let res = result, isSuccess {
                self.update(exchanges: res)
                self.exchangesCallback?(res)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return allTokenRows.count
    }
    
    func item(for row: Int, setction: Int = 0) -> BancorExchange {
        return allTokenRows[row]
    }
    
    func cellViewModel(for indexPath: IndexPath) -> BancorExchangeCellViewModel {
        let exchange = allTokenRows[indexPath.row]
        return BancorExchangeCellViewModel(exchange: exchange)
    }
    
    func detailViewModel(for indexPath: IndexPath) -> BancorExchangeDetailViewModel {
        let exchange = allTokenRows[indexPath.row]
        return BancorExchangeDetailViewModel(exchange: exchange)
    }
    
    func hasContent() -> Bool {
        return !allTokenRows.isEmpty
    }
    
    // MARK: - help Methods
    func update(exchanges: [BancorExchange]) {
        tokensRows = exchanges.compactMap({ a -> BancorExchange? in
            return a
        })
        if skip == 0 {
            allTokenRows = tokensRows
        }else {
            allTokenRows.append(contentsOf: tokensRows)
        }
    }
    func update(rate: BancorRate) {
        self.rate  = rate
    }
    
}
