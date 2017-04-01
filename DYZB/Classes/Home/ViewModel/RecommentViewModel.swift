//
//  RecommentViewModel.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/20.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class RecommentViewModel: BaseViewModel {
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

extension RecommentViewModel {
    func requestData(finishedCallback: @escaping () -> ()) {
        let parameters: [String: NSString] = ["limit" : "4", "offset" : "0", "time": Date.getCurrentTime() as NSString]
        
        let dispatch_group = DispatchGroup()
        
        dispatch_group.enter()
        //1. 请求第一部分推荐数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1489995064.90629
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": Date.getCurrentTime() as NSString], successCallback: { (result) in
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {
                return
            }

            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dispatch_group.leave()
            
        }) { (error) in
            print(error)
            
            dispatch_group.leave()
        }
        
        //2. 请求第二部分颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=4&time=1489995064.90629
        dispatch_group.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, successCallback: { (result) in
            
            guard let resultDict = result as? [String: NSObject] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else {
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)

                self.prettyGroup.anchors.append(anchor)
            }
            
            dispatch_group.leave()
            
        }) { (error) in
            print(error)
            dispatch_group.leave()
        }
        
        //3.请求后面部分游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=4&time=1489995064
        dispatch_group.enter()
        loadAnchorData(isGroupData: true,URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dispatch_group.leave()
        }
        
        dispatch_group.notify(queue: DispatchQueue.main) {
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
    }
    
    //http://www.douyutv.com/api/v1/slide/6?version=2.300
    func requestCycleData(finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version": "2.300"], successCallback: { (result) in
            guard let resultDict = result as? [String: Any] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {
                return
            }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishedCallback()
            
        }) { (error) in
            print(error)
        }
    }
}
