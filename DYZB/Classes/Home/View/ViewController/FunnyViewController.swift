//
//  FunnyViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/30.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

private let kTopMargin: CGFloat = 8.0

class FunnyViewController: BaseAnchorViewController {
    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

extension FunnyViewController {
    override func setupData() {
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            self.loadDidFinished()
        }
    }
}
