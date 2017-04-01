//
//  Date-Extension.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/20.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
