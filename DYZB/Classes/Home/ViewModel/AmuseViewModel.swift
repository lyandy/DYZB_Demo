//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/30.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback: @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
