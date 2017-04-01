//
//  GameShowViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/22.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

private let kEdgeMargin: CGFloat = 10.0
private let kItemW: CGFloat = (kScreenW - 2 * kEdgeMargin) / 3.0
private let kItemH: CGFloat = kItemW * 6.0 / 5.0
private let kGameViewH: CGFloat = 90.0

class GameShowViewController: BaseViewController {
    
    fileprivate lazy var gameShowVM: GameShowViewModel = GameShowViewModel()

    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()
    
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    
    fileprivate lazy var gameView: GameView = {
        let gameView = GameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GameShowViewController {
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
    }
}

extension GameShowViewController {
    fileprivate func loadData() {
        gameShowVM.loadAllGameData {
            self.collectionView.reloadData()
            
//            let groups = self.gameShowVM.games[0..<10]
            
//            var tempArray = [BaseGameModel]()
//            
//            for i in 0..<10 {
//                tempArray.append(self.gameShowVM.games[i])
//            }
//            
//            self.gameView.groups = tempArray
            
            //超出数组的索引取值或崩溃
            self.gameView.groups = Array(self.gameShowVM.games[0..<10])
            
            self.loadDidFinished()
        }
    }
}

extension GameShowViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameShowVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionGameCell

        cell.baseGame = gameShowVM.games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath) as! CollectionHeaderView
        
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}





















