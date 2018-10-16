// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class BancorFormatters {
    
    static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        return formatter
    }
    
    static var percentFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .percent
        return formatter
    }
    
    static func formatter(minimumFractionDigits: Int, maximumFractionDigits: Int) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        return formatter
    }
}
