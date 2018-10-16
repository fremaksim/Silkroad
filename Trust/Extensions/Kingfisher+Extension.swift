// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import Kingfisher


extension Kingfisher {
    
//    ImageDownloader.default.downloadTimeout = 30
    
    static func resetTimeout(time: TimeInterval) {
        let downloader = KingfisherManager.shared.downloader
        // 修改超时时间
        downloader.downloadTimeout = time 
    }
  
}
