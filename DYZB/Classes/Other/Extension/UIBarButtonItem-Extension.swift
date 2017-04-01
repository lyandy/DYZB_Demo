//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/16.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    class func createItem(imageName : String, highLightedImageName : String, size : CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : highLightedImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn);
    }
    
    convenience init(imageName : String, highLightedImageName : String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named : imageName), for: .normal)
        if highLightedImageName != "" {
            btn.setImage(UIImage(named : highLightedImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }
        else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView : btn)
    }
}
