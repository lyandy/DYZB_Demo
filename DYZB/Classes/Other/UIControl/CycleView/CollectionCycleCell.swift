//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/22.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel: CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            
            guard let iconUrl = URL(string: cycleModel?.pic_url ?? "") else {
                return
            }
            
            iconImageView.kf.setImage(with: iconUrl)
        }
    }

}
