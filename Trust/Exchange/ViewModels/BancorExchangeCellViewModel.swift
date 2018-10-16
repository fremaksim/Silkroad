// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

final class BancorExchangeCellViewModel {
    
    var exchange: BancorExchange
    
    init(exchange: BancorExchange) {
        self.exchange = exchange
        
    }
    // 图片
    var imageURL: URL? {
        if let imageName = exchange.primaryCommunityImageName {
            return URL(string: "https://files.bancor.network/0.1/images/communities?imageName=\(imageName)&imageWidth=400")
        }else{
            return nil
        }
    }
    
    // code
    var code: String {
        return exchange.code ?? ""
    }
    
    // name
    var name: String {
        return exchange.name ?? ""
    }
    
    // price
    var priceUSD: String {
        if let price = exchange.price ,let doublePrice = Double(price), let usdRate =  exchange.rate.data?["USD"] {
//            return "$\(price)"
            return BancorFormatters.formatter.string(from: NSNumber(value: doublePrice * usdRate))?.replacingOccurrences(of: "US", with: "") ?? "$0.0"
        }else{
            return "$0.0"
        }
    }
    
    // 24h涨幅
    var twoFourHour: String {
        if let change24h = exchange.change24h {
            return String(change24h)
        }else{
            return "0.0"
        }
        
    }
    
}
