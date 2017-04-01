//
//  GameShowViewModel.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/23.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class GameShowViewModel {
    
    lazy var games: [GameModel] = [GameModel]()

}

extension GameShowViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        
        
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName": "game"], successCallback: { (result) in
            guard let resultDict = result as? [String: Any] else {
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String: Any]] else {
                return
            }
            
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallback()
            
        }) { (error) in
            print(error)
        }
    }
}
