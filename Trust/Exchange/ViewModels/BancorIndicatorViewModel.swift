// Copyright DApps Platform Inc. All rights reserved.

import Foundation


final class BancorIndicatorViewModel {
    
    private var viewModel: BancorExchangeCellViewModel
    
    init(viewModel: BancorExchangeCellViewModel) {
        self.viewModel = viewModel
    }
    
    // +
    func showAddStyle() -> Bool {
        return viewModel.twoFourHour.doubleValue > 0
    }
    
    func twoFourHourChange() -> String {
        let prefix =  showAddStyle() ? "+" : "-"
        
        let percent = fabs(viewModel.twoFourHour.doubleValue * 0.01)
        if let str =  BancorFormatters.percentFormatter.string(from: NSNumber(value: percent)) {
            return prefix + str
        }
        return "0.00%"
    }
    
    
    
    
    
}
