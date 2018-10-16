// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class BancorSearchExchangeCellViewModel {
    var exchange: BancorSearchExchange
    
    init(exchange: BancorSearchExchange) {
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
    
}

