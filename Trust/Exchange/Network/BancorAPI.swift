// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import Moya

enum BancorAPI {
    //https://api.bancor.network/0.1/currencies/tokens?limit=15&skip=0&fromCurrencyCode=ETH&includeTotal=true&orderBy=code&sortOrder=desc&q=px
    // 交易所列表，查询排序 等等
    case searchTokens(limit: Int, skip: Int,
        fromCurrencyCode: String, includeTotal: Bool,
        orderBy: String, sortOrder: String, minimalDataOnly: Bool?, q: String?)
    
    //https://api.bancor.network/0.1/currencies/tokens?limit=15&skip=0&fromCurrencyCode=ETH&includeTotal=false&orderBy=liquidityDepth&sortOrder=desc&minimalDataOnly=true
    
    //https://api.bancor.network/0.1/currencies/rate?toCurrencyCode=ETH&fromCurrencyCodes=USD,EUR
    // 以太币兑换美元，欧元的汇率
    case getRate(toCurrencyCode: String, fromCurrencyCodes: String)
    
    //https://api.bancor.network/0.1/currencies/5937d635231e97001f744267?includeRelay=true
    //指定交易所详情信息
    case getTokenDetail(id: String, includeRelay: Bool)
    
    /*   // https://api.bancor.network/0.1/currencies/change
     // Request
     {
     "blockchainType": "ethereum",
     "fromCurrencyId": "5937d635231e97001f744267",
     "toCurrencyId": "594bb7e468a95e00203b048d",
     "amount": "100000000000000000",
     "minimumReturn": "14913236268545655000",
     "ownerAddress": "0x7321b448e143e736ad1adae6e217306de9b84122"
     }
     // Response
     {
     "data": [
     {
     "from": "0x7321b448e143e736ad1adae6e217306de9b84122",
     "to": "0x3839416bd0095d97be9b354cbfb0f6807d4d609e",
     "data": "0x227420000000000,
     "value": "0x16345785d8a0000",
     "gasPrice": "0x165a0bc00",
     "nonce": "0x21",
     "gasLimit": "0x58139"
     }
     ]
     }
     */
    // 兑换（买卖）
    case change(blockchainType: String, fromCurrencyId: String,
        toCurrencyId: String, amount: String,
        minimumReturn: String, ownerAddress: String)
    
    // 图片
    case fileImages(imageName: String)
    
    // 加载所有Bancor以太坊交易所
    /*
     type  = "ethereum",
     stage = "traded",
     skip  = 0,
     limit = 70,
     excludeSubTypes = "bounty,relay"
     */
    case loadAllExchange(type: String ,stage: String,
        skip: Int, limit: Int,excludeSubTypes: String)
    
    
}


extension BancorAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .fileImages:
            return Constants.bancorImageAPI
        default:
            return Constants.bancorAPI
        }
    }
    
    var path: String {
        switch self {
        case .searchTokens:
            return "/0.1/currencies/tokens"
        case .getRate:
            return "/0.1/currencies/rate"
        case .getTokenDetail(let value):
            return "/0.1/currencies/\(value.id)"
        case .change:
            return "/0.1/currencies/change"
        case .fileImages:
            return "/0.1/images/communities"
        case .loadAllExchange:
            return "/0.1/currencies"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchTokens:
            return .get
        case .getRate:
            return .get
        case .getTokenDetail:
            return .get
        case .change:
            return .post
        case .fileImages:
            return .get
        case .loadAllExchange:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .searchTokens(let limit, let skip, let fromCurrencyCode, let includeTotal, let orderBy, let sortOrder, let minimalDataOnly, let q):
            var params: [String: Any] = ["limit": limit,
                                         "skip": skip,
                                         "fromCurrencyCode":  fromCurrencyCode,
                                         "includeTotal": includeTotal,
                                         "orderBy": orderBy,
                                         "sortOrder": sortOrder]
            if let minimalDataOnly = minimalDataOnly {
                params["minimalDataOnly"] = minimalDataOnly
            }
            if let q = q {
                params["q"] = q
            }
            return .requestParameters(parameters: params, encoding: URLEncoding())
        case .getRate(let toCurrencyCode, let fromCurrencyCodes):
            let params: [String: Any] = ["toCurrencyCode": toCurrencyCode,
                                         "fromCurrencyCodes": fromCurrencyCodes]
            return .requestParameters(parameters: params, encoding: URLEncoding())
        case .getTokenDetail(let id, let includeRelay):
            return .requestParameters(parameters: ["id": id, "includeRelay": includeRelay], encoding: URLEncoding())
        case .change(let blockchainType, let fromCurrencyId, let toCurrencyId, let amount, let  minimumReturn, let ownerAddress):
            let params: [String: Any] = ["blockchainType": blockchainType,
                                         "fromCurrencyId": fromCurrencyId,
                                         "toCurrencyId": toCurrencyId,
                                         "amount": amount,
                                         "minimumReturn": minimumReturn,
                                         "ownerAddress": ownerAddress]
            return .requestParameters(parameters: params, encoding: URLEncoding())
        case .fileImages(let imageName):
            let params: [String: Any] = ["imageName": imageName,"imageWidth": 400]
            return .requestParameters(parameters:params , encoding: URLEncoding())
        case .loadAllExchange(let type, let stage, let skip, let limit, let excludeSubTypes):
            let params: [String: Any] = ["type": type, "stage": stage,
                                         "skip": skip,"limit": limit, "excludeSubTypes": excludeSubTypes]
            return .requestParameters(parameters: params, encoding: URLEncoding())
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json,text/plain",
            "client": Bundle.main.bundleIdentifier ?? "",
            "client-build": Bundle.main.buildNumber ?? "",
        ]
    }
    
    
}
