// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BancorIconCollectionFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        let width = CGFloat(floorf(Float(CommonDevices.screenWidth / 3.0)))
        
        itemSize = CGSize(width: width, height: width)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
