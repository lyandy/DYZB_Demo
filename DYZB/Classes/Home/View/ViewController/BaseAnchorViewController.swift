//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/30.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10.0
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2.0
let kNormalItemH = kNormalItemW * 3.0 / 4.0
let kPrettyItemH = kNormalItemW * 4.0 / 3.0

let kNormalCellId = "kNormalCellId"
let kPrettyCellId = "kPrettyCellId"

class BaseAnchorViewController: BaseViewController {

    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        
        return collectionView
        }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupData()

        // Do any additional setup after loading the view.
    }
}

extension BaseAnchorViewController {
    override func setupUI() {
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

extension BaseAnchorViewController {
    func setupData() {
    }
}

extension BaseAnchorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath) as! CollectionHeaderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

extension BaseAnchorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
        anchor.isVertical == 0 ? pushRoomNormalViewController() : presentRoomShowViewController()
    }
    
    private func presentRoomShowViewController() {
        let roomShowVC = RoomShowViewController()
        present(roomShowVC, animated: true, completion: nil)
    }
    
    private func pushRoomNormalViewController() {
        let roomNormalVC = RoomNormalViewController()
        navigationController?.pushViewController(roomNormalVC, animated: true)
    }
}












