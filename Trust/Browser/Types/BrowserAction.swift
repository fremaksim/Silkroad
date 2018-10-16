// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

enum BrowserNavigation {
    case goBack
    case more(sender: UIView)
    case home
    case changehome//做了修改    首页主页
    case enter(String)
    case beginEditing
}
