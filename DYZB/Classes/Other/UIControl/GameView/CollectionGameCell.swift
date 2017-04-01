//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/22.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    @IBOutlet weak var iconImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var baseGame: BaseGameModel? {
        didSet {
            
            titleLabel.text = baseGame?.tag_name
            
            if let iconUrl = URL(string: baseGame?.icon_url ?? "") {
                iconImageview.kf.setImage(with: iconUrl)
            } else {
                iconImageview.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
