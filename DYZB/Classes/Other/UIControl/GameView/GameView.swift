//
//  GameView.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/22.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

private let kEdgeInsetMargin: CGFloat = 10

class GameView: UIView {
    
    var groups: [BaseGameModel]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        autoresizingMask = []
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

extension GameView {
    class func gameView() -> GameView {
        return Bundle.main.loadNibNamed("GameView", owner: nil, options: nil)?.first as! GameView
    }
}

extension GameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionGameCell
        
        let group = groups![indexPath.item]
        
        cell.baseGame = group
        
        return cell
    }
}
