// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

final class BancorImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.width / 2.0
        layer.borderColor  = UIColor.white.cgColor
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
}
