//
//  BaseGameModel.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    var tag_name: String = ""
    
    var icon_url: String = ""
    
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
