// Copyright DApps Platform Inc. All rights reserved.

import RealmSwift
import Realm
import Foundation

final class BancorExchangeList: Decodable {
   var data: BancorExchangeCurrencies?
    
   convenience init(data: BancorExchangeCurrencies) {
     self.init()
     self.data = data
    }
    
    private enum BancorExchangeListCodingKeys: String, CodingKey {
        case data
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BancorExchangeListCodingKeys.self)
        let data = try container.decode(BancorExchangeCurrencies.self, forKey: .data)
        
        self.init(data: data)
    }
    
}

final class BancorExchangeCurrencies: Decodable {
    var currencies: BancorExchangeCurrenciesTotal?
    
    convenience init(currencies: BancorExchangeCurrenciesTotal) {
        self.init()
        self.currencies = currencies
    }
    
    private enum BancorExchangeCurrenciesCodingKeys: String, CodingKey {
        case currencies
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BancorExchangeCurrenciesCodingKeys.self)
        let currencies = try container.decode(BancorExchangeCurrenciesTotal.self, forKey: .currencies)
        
        self.init(currencies: currencies)
    }
}

final class BancorExchangeCurrenciesTotal: Decodable {
//    var total: Int? 
    var page: [BancorExchange]?
    
    convenience init(page: [BancorExchange], total: Int?) {
        self.init()
//        self.total = total
        self.page  = page
    }
    private enum BancorExchangeCurrenciesTotalCodingKeys: String, CodingKey {
//        case total
        case page
    }
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BancorExchangeCurrenciesTotalCodingKeys.self)
   
        let itemsArray = try container.decode([BancorExchange].self, forKey: .page)
        
//        if  let total = try container.decode(Int?.self, forKey: .total) {
//            self.init(page: itemsArray, total: total)
//        }else {
//        }
        self.init(page: itemsArray, total: nil)
    
        
    }
    
}

final class BancorExchange: Decodable {
    
    var rate: BancorRate = BancorRate()
    
    var _id: String?
    var supply: String?
    var price: String?
    var liquidityDepth: Double? = 0.0
    var change24h: Double? = 0.0
    var code: String?
    var name: String?
    var primaryCommunityId: String?
    var primaryCommunityImageName: String?
    var volume24h: [String: Double]? = ["ETH": 0.0,
                                                     "USD": 0.0,
                                                     "EUR": 0.0]
    var priceHistory: [[Double]]? = [[0,0.0]]
    
    convenience init(_id: String,
                     supply: String?,
                     price: String,
                     liquidityDepth: Double = 0.0,
                     change24h: Double = 0.0,
                     code: String,
                     name: String,
                     primaryCommunityId: String,
                     primaryCommunityImageName: String,
                     volume24h: [String: Double] = ["ETH": 0.0,
                                                    "USD": 0.0,
                                                    "EUR": 0.0],
                     priceHistory: [[Double]]) {
        self.init()
        self._id = _id
        self.supply = supply
        self.liquidityDepth = liquidityDepth
        self.change24h = change24h
        self.price = price
        self.code = code
        self.name = name
        self.primaryCommunityId = primaryCommunityId
        self.primaryCommunityImageName = primaryCommunityImageName
        
        self.volume24h = volume24h
        self.priceHistory = priceHistory
    }
 
    
    private enum BancorExchangeCodingKeys: String, CodingKey {
        
        case _id
        case supply
        case price
        case liquidityDepth
        case change24h
        case code
        case name
        case primaryCommunityId
        case primaryCommunityImageName
        case volume24h
        case priceHistory
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: BancorExchangeCodingKeys.self)
        let _id = try container.decode(String.self, forKey: ._id)
        let supply = try container.decode(String.self, forKey: .supply)
        let price = try container.decode(String.self, forKey: .price)
        let liquidityDepth = try container.decode(Double.self, forKey: .liquidityDepth)
        let change24h = try container.decode(Double.self, forKey: .change24h)
        let code = try container.decode(String.self, forKey: .code)
        let name = try container.decode(String.self, forKey: .name)
        let primaryCommunityId = try container.decode(String.self, forKey: .primaryCommunityId)
        let primaryCommunityImageName = try container.decode(String.self, forKey: .primaryCommunityImageName)
        let volume24h = try container.decode([String: Double].self, forKey: .volume24h)
        let priceHistory = try container.decode([[Double]].self, forKey: .priceHistory)
        
        self.init(_id: _id, supply: supply, price: price, liquidityDepth: liquidityDepth, change24h: change24h, code: code, name: name, primaryCommunityId: primaryCommunityId, primaryCommunityImageName: primaryCommunityImageName, volume24h: volume24h, priceHistory: priceHistory)
        
    }
    

}
