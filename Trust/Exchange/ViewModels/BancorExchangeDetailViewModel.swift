// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class BancorExchangeDetailViewModel {
    
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
        guard let change = exchange.change24h else { return "0.00%"}
        let prefix =  (change > 0) ? "+" : "-"
        let percent = fabs(change * 0.01)
        if let str =  BancorFormatters.percentFormatter.string(from: NSNumber(value: percent)) {
            return prefix + str
        }
        return "0.00%"
        
    }
    
    // 24h volume
    var towFourVolume: String {
        if let volume = exchange.volume24h?["USD"] {
            return BancorFormatters.formatter(minimumFractionDigits: 0, maximumFractionDigits: 0).string(from: NSNumber(value: volume))?.replacingOccurrences(of: "US", with: "") ?? "$0.0"
        }
        return "$0.0"
    }
    
    // Liquidity Depth
    var liquidityDepth: String {
        if let depth = exchange.liquidityDepth {
            return BancorFormatters.formatter(minimumFractionDigits: 0, maximumFractionDigits: 0).string(from: NSNumber(value: depth))?.replacingOccurrences(of: "US", with: "") ?? "$0.0"
        }else{
            return "$0.0"
        }
    
    }
    
    
}
