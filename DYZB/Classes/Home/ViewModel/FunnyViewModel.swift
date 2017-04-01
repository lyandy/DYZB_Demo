//
//  FunnyViewModel.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/30.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishedCallback: @escaping  () -> ()) {
        loadAnchorData(isGroupData: false,URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit": 30, "offset": 0], finishedCallback: finishedCallback)
    }
}
