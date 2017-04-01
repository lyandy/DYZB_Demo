//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/20.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    var group: AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
