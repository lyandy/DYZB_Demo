//
//  PageContentView.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/17.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellId = "ContentCellId"
private let BtnLiveH: CGFloat = 44.0
private let BtnLiveW: CGFloat = BtnLiveH
private let BtnLiveMargin: CGFloat = 10.0

class PageContentView: UIView {
    
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    fileprivate var childVCs: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    weak var delegate: PageContentViewDelegate?
    
    fileprivate lazy var btnLive: UIButton = {[unowned self] in
        let btnLive = UIButton()
        
        btnLive.setImage(UIImage(named:"btn_livevideo_start_home"), for: .normal)
        
        btnLive.frame = CGRect(x: self.bounds.width - BtnLiveW - BtnLiveMargin, y: self.bounds.height - BtnLiveH - BtnLiveMargin, width: BtnLiveW, height: BtnLiveH)
        
        btnLive.addTarget(self, action: #selector(self.pushRoomLiveConfigViewController), for: .touchUpInside)
        
        return btnLive
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true;
        collectionView.bounces = false;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.scrollsToTop = false;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        
        return collectionView
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    fileprivate func setupUI() {
        for childVC in childVCs {
            parentViewController?.addChildViewController(childVC)
        }
        
        addSubview(collectionView)
        
        collectionView.frame = bounds
        
        addSubview(btnLive)
    }
    
    @objc fileprivate func pushRoomLiveConfigViewController() {
        let roomLiveConfigVC = RoomLiveConfigViewController()

        self.viewController.navigationController?.pushViewController(roomLiveConfigVC, animated: true)
    }
}

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > startOffsetX {
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    func setCurrentIndex(_ currentIndex: Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}








