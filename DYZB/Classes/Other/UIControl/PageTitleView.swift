//
//  PageTitleView.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/16.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}

private let kScrollLineH : CGFloat = 2.0
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {

    //MARK: - 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK: - 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        
        self.titles = titles;
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    
    fileprivate func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitlesLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitlesLabels() {
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0.0
        
        for(index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        let bottomLine = UIView()
        
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        
    }
}

extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes: UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        if currentLabel.tag == currentIndex {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.3) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveToatalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveToatalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex;
    }
}































