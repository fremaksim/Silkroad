// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class BancorRate: Decodable {
     var data: [String: Double]?
    
    convenience init(data: [String: Double]) {
        self.init()
        self.data = data
    }
    

    
    private enum BancorRateCodingKeys: String, CodingKey {
        case data = "data"
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BancorRateCodingKeys.self)
        let data = try container.decode([String: Double].self, forKey: .data)
        
        self.init(data: data)
    }
}
