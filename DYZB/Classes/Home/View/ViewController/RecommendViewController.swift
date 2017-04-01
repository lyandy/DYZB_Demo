//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/17.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

private let kCycleViewH: CGFloat = kScreenW * 3.0 / 8.0
private let kGameViewH: CGFloat = 90.0

class RecommendViewController: BaseAnchorViewController {
    
    fileprivate lazy var recommendVM: RecommentViewModel = RecommentViewModel()
    
    fileprivate lazy var cycleView: CycleView = {
        let cycyleView = CycleView.cycleView()
        cycyleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycyleView
    }()
    
    fileprivate lazy var gameView: GameView = {
        let gameView = GameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
}

extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension RecommendViewController {
    override func setupData() {
        
        baseVM = recommendVM
        
        recommendVM.requestData {[weak self] in
            self?.collectionView.reloadData()
            
            var groups = self?.recommendVM.anchorGroups
            
            groups?.removeFirst()
            groups?.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            self?.gameView.groups = groups
            
            self?.loadDidFinished()
        }
        
        recommendVM.requestCycleData {[weak self] in
            self?.cycleView.cyclemodels = self?.recommendVM.cycleModels
        }
        
        super.setupData()
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            // 1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}

