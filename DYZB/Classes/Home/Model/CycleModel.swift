//
//  CycleModel.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/22.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title: String = ""
    
    var pic_url: String = ""
    
    var room: [String: Any]? {
        didSet {
            guard let room = room else {
                return
            }
            
            anchor = AnchorModel(dict: room)
        }
    }
    
    var anchor: AnchorModel?
    
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
