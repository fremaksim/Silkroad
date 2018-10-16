// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }
    
    func imageOnRight() {
        //https://stackoverflow.com/questions/7100976/how-do-i-put-the-image-on-the-right-side-of-the-text-in-a-uibutton/28440475
        if CommonDevices.systemVersion >= "10.0" {
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }else{
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
    }
}
