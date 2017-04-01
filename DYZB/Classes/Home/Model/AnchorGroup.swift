//
//  AnchorGroup.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/20.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    
    var room_list: [[String: NSObject]]? {
        didSet {
            guard let room_list = room_list else {
                return
            }
            
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    var icon_name: String = "home_header_normal"
    
    
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArray = value as? [[String: NSObject]] {
//                for dict in dataArray {
//                    anchors.append(AnchorModel(dict: dict))
//                }
//            }
//            
//        }
//    }
}
