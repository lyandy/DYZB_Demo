//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/30.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class AmuseMenuViewCell: UICollectionViewCell {
    
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let layoutItemW = collectionView.bounds.width / 4.0
        let layoutItemH = collectionView.bounds.height / 2.0
        
        layout.itemSize = CGSize(width: layoutItemW, height: layoutItemH)
    }
}

extension AmuseMenuViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
    }
}
