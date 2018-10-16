// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class BancorSearchViewModel {
    
    let network: BancorSubNetworkProtocol = BancorNetwork(provider: BancorProviderFactory.makeProvider())

    
    func loadingAllExchanges(completion: @escaping ([BancorSearchExchange]?, Bool) -> Void) {
        network.loadAllExchange(type: "ethereum", stage: "traded", skip: 0, limit: 70, excludeSubTypes: "bounty,relay") { (list, isSuccess) in
            completion(list,isSuccess)
        }
        
    }
}
