// Copyright DApps Platform Inc. All rights reserved.

import PromiseKit
import Moya
import APIKit
import Result
import BigInt

import enum Result.Result

protocol BancorNetworkProtocol {
    var provider: MoyaProvider<BancorAPI> { get }
}

protocol BancorSubNetworkProtocol: BancorNetworkProtocol {
    func tokens(limit: Int, skip: Int,
                fromCurrencyCode: String, includeTotal: Bool,
                orderBy: String, sortOrder: String, minimalDataOnly: Bool?, q: String?, completion: @escaping ([BancorExchange]?, Bool)-> Void)
    
    func getRate(completion: @escaping (BancorRate?) -> Void)
    
    func loadAllExchange(type: String ,stage: String,
                         skip: Int, limit: Int,excludeSubTypes: String, completion: @escaping ([BancorSearchExchange]?, Bool)-> Void)
    
}

final class BancorNetwork: BancorSubNetworkProtocol {
    
    let provider: MoyaProvider<BancorAPI>
    
    init(provider: MoyaProvider<BancorAPI>) {
        self.provider = provider
    }
    
    func getRate(completion: @escaping (BancorRate?) -> Void) {
        provider.request(.getRate(toCurrencyCode: "ETH", fromCurrencyCodes: "USD,EUR")) { (result) in
            switch result {
            case .success(let response):
                do {
                    let rate = try response.map(BancorRate.self)
                    completion(rate)
                }catch {
                    completion(nil)
                }
                
            case .failure(let error):
                SRLog(message: error)
                completion(nil)
            }
        }
    }
    
    
    func tokens(limit: Int, skip: Int, fromCurrencyCode: String, includeTotal: Bool, orderBy: String, sortOrder: String, minimalDataOnly: Bool?, q: String?, completion: @escaping ([BancorExchange]?, Bool) -> Void) {
        provider.request(.searchTokens(limit: limit, skip: skip, fromCurrencyCode: fromCurrencyCode, includeTotal: includeTotal, orderBy: orderBy, sortOrder: sortOrder, minimalDataOnly: minimalDataOnly, q: q)) { result in
            switch result {
            case .success(let response):
                do {
                    let list = try response.map(BancorExchangeList.self)
                    let targetList = list.data?.currencies?.page
                    completion(targetList,true)
                }catch {
                    SRLog(message: error)
                    completion(nil,false)
                }
            case .failure(_):
                completion(nil,false)
            }
        }
    }

    func loadAllExchange(type: String, stage: String, skip: Int, limit: Int, excludeSubTypes: String,completion: @escaping ([BancorSearchExchange]?, Bool) -> Void) {
        provider.request(.loadAllExchange(type: type, stage: stage, skip: skip, limit: limit, excludeSubTypes: excludeSubTypes)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let list = try response.map(BancorSearchExchangeList.self)
                    let targetList = list.data?.currencies?.page
                    completion(targetList,true)
                }catch {
                    SRLog(message: error)
                }
            case .failure(let error):
                SRLog(message: error.localizedDescription)
            }
        }
    }
}
