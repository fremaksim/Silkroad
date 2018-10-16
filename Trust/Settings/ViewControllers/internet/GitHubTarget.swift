//
//  GitHubTarget.swift
//  SolarKit-SwiftExample
//
//  Created by wyh on 2018/1/12.
//  Copyright © 2018年 SolarKit. All rights reserved.
//

import Foundation
import SolarNetwork

struct GitHubTarget: SLTarget {

    var baseURLString: String { return "http://69.171.72.114:8088/version.json" }
    var IPURLString: String? {
        get {
            return storeIPURLString
        }
        set {
            storeIPURLString = newValue
        }
    }
    var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
//    var serverTrustPolicies: [String : ServerTrustPolicy]? {
//        #if DEBUG
//            let validateCertificateChain = false
//            let validateHost = false
//        #else
//            let validateCertificateChain = true
//            let validateHost = true
//        #endif
    
//        let policies: [String: ServerTrustPolicy] = [
//            host: .pinCertificates(
//                certificates: ServerTrustPolicy.certificates(),
//                validateCertificateChain: validateCertificateChain,
//                validateHost: validateHost
//            )
//        ]
//        return policies
//
//    }
//
//    var clientTrustPolicy: (secPKCS12Name: String, password: String)? {
//        return (secPKCS12Name: "github", password: "123456")
//    }
    
//    var plugins: [SLPlugin]? {
//        return [GitHubPlugin()]
//    }
    
    var storeIPURLString: String?
}
