
// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

struct CommonDevices {
    
    static var isIPhoneXSeries: Bool {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return false
        }
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.delegate?.window,
                let mainWindow = window,mainWindow.safeAreaInsets.bottom > 0.0{
                return true
            }
            return false
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    static var navigationBarBottomMaxY: CGFloat {
        if self.isIPhoneXSeries {
            return 88.0
        }else{
            return 64.0
        }
    }
    
    static var tabbarTopDistanceBottom: CGFloat {
        if self.isIPhoneXSeries {
            return 83.0
        }else {
            return 48.0
        }
    }
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var systemVersion: String {
        return UIDevice.current.systemVersion
    }
}
