//
//  CycleView.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/21.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

private let kCycleCellId = "kCycleCellId"

class CycleView: UIView {

    var cycleTimer: Timer?
    
    var cyclemodels: [CycleModel]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = cyclemodels?.count ?? 0
          
            let indexPath = IndexPath(item: (cyclemodels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .top, animated: false)

            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        
        autoresizingMask = []

        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
    }
    
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension CycleView {
    class func cycleView() -> CycleView {
        return Bundle.main.loadNibNamed("CycleView", owner: nil, options: nil)?.first as! CycleView
    }
}

extension CycleView: UICollectionViewDataSource {
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cyclemodels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionCycleCell
        
        let cycleModel = cyclemodels![indexPath.item % (cyclemodels?.count)!]
        cell.cycleModel = cycleModel
        
        return cell
    }
}

extension CycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width / 2.0
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cyclemodels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension CycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode:RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
















