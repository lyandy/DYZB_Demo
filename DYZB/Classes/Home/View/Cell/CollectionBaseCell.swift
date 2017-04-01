//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/21.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor: AnchorModel? {
        didSet {
            
            guard let anchor = anchor else {
                return
            }
            
            var onlineStr: String = ""
            
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online / 10000)在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            guard let iconUrl = URL(string: anchor.vertical_src) else {
                return
            }
            
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
}
