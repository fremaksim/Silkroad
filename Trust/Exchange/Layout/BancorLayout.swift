// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

struct BancorLayout {
    struct tableView {
        static let height: CGFloat = 80
        static let layoutInsets = UIEdgeInsets(top: 0, left: 84, bottom: 0, right: 0)
    }
    
    struct cell {
        static let seperatorLineHeight: CGFloat = 8
        static let stackVericalOffset: CGFloat = 10
        static let arrangedSubviewsOffset: CGFloat = 4
        static var imageSize: CGFloat {
            return 40
        }
        
        static let indicatorViewSize: CGSize = CGSize(width: 80, height: 35)
        
    }
    

}
