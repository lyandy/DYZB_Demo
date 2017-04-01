//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/20.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: AnchorModel? {
        didSet {
            
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
