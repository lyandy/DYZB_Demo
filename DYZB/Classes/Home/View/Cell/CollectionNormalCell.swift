//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/20.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor: AnchorModel? {
        didSet {
            
            super.anchor = anchor
            
            roomNameLabel.text = anchor?.room_name
        }
    }


}
