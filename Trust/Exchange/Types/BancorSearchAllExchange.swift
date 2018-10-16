// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class BancorSearchExchangeList: Decodable {
    var data: BancorSearchExchangeCurrencies?
    
    convenience init(data: BancorSearchExchangeCurrencies) {
        self.init()
        self.data = data
    }
    
    private enum BancorSearchExchangeListCodingKeys: String, CodingKey {
        case data
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BancorSearchExchangeListCodingKeys.self)
        let data = try container.decode(BancorSearchExchangeCurrencies.self, forKey: .data)
        
        self.init(data: data)
    }
    
}



final class BancorSearchExchangeCurrencies: Decodable {
    
    var currencies: BancorSearchExchangeCurrenciesModel?
    
    convenience init(currencies: BancorSearchExchangeCurrenciesModel?) {
        self.init()
        self.currencies = currencies
    }
    
    private enum BancorSearchExchangeCurrenciesCodingKeys: String, CodingKey {
        case currencies
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BancorSearchExchangeCurrenciesCodingKeys.self)
        let currencies = try container.decode(BancorSearchExchangeCurrenciesModel.self, forKey: .currencies)
        
        self.init(currencies: currencies)
    }

    
}

final class BancorSearchExchangeCurrenciesModel: Decodable {
    var includeTotal: Bool?
    var skip: Int?
    var limit: Int?
    var page: [BancorSearchExchange]?
}

final class BancorSearchExchange: Decodable {
    
    var _id: String?
    var symbol: String?
    var code: String?
    var type: String?
    var details: [String : Any]?
    var status: String?
    var stage: String?
    var createdAt: String?
    var primaryCommunityId: String?
    var primaryCommunityImageName: String?
    var numDecimalDigits: Int?
    var name: String?
    var isDeleted: Bool?
    var order: Int?
    var isDiscoverable: Bool?
    var lowerCaseSymbol: String?
    var lowerCaseCode: String?
    var about: String?
    var description: String?
    var adminProfileId: String?
    
    convenience init(_id: String?,
                     symbol: String?,
                     code: String?,
                     type: String?,
                     details: [String: Any]?,
                     status: String?,
                     stage: String?,
                     createdAt: String?,
                     primaryCommunityId: String?,
                     primaryCommunityImageName: String?,
                     numDecimalDigits: Int?,
                     name: String?,
                     isDeleted: Bool?,
                     order: Int?,
                     isDiscoverable: Bool?,
                     lowerCaseSymbol: String?,
                     lowerCaseCode: String?,
                     about: String?,
                     description: String?,
                     adminProfileId: String?
        ) {
        self.init()
        
        self._id = _id
        self.symbol = symbol
        self.code = code
        self.type = type
        self.details = details
        self.status = status
        self.stage = stage
        self.createdAt = createdAt
        self.primaryCommunityId = primaryCommunityId
        self.primaryCommunityImageName = primaryCommunityImageName
        self.numDecimalDigits = numDecimalDigits
        self.name = name
        self.isDeleted = isDeleted
        self.order = order
        self.isDiscoverable = isDiscoverable
        self.lowerCaseCode = lowerCaseCode
        self.lowerCaseSymbol = lowerCaseSymbol
        self.about = about
        self.description = description
        self.adminProfileId = adminProfileId
        self.description = description
        
    }
    
    private enum BancorSearchExchangeCodingKeys: String, CodingKey {
        
        case _id
        case symbol
        case code
        case name
        case type
        //        case details
        case status
        case stage
//        case primaryCommunityId
        case primaryCommunityImageName
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: BancorSearchExchangeCodingKeys.self)
        let _id = try container.decode(String.self, forKey: ._id)
        let symbol = try container.decode(String.self, forKey: .symbol)
        let type = try container.decode(String.self, forKey: .type)
        let status = try container.decode(String.self, forKey: .status)
        //        let details = try container.decode([String: Any].self, forKey: .details)
        let code = try container.decode(String.self, forKey: .code)
        let name = try container.decode(String.self, forKey: .name)
//        let primaryCommunityId = try container.decode(String?.self, forKey: .primaryCommunityId)
        let primaryCommunityImageName = try container.decode(String.self, forKey: .primaryCommunityImageName)
        
        
        self.init(_id: _id, symbol: symbol, code: code, type:type, details: nil, status: status, stage: nil, createdAt: nil, primaryCommunityId: nil, primaryCommunityImageName: primaryCommunityImageName, numDecimalDigits: nil, name: name, isDeleted: nil, order: nil, isDiscoverable: nil, lowerCaseSymbol: nil, lowerCaseCode: nil, about: nil, description: nil, adminProfileId: nil)
        
    }
    
}
