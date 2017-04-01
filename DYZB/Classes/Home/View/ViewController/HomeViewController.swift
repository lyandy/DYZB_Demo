//
//  HomeViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/16.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

private var kPageTitleViewH : CGFloat = 48

class HomeViewController: UIViewController {
    
    //MARK: - 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles);
        titleView.delegate = self
        return titleView;
    }()
    
    fileprivate lazy var pageContentView: PageContentView = {[weak self] in
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kPageTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kPageTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()

        childVCs.append(RecommendViewController())
        childVCs.append(GameShowViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
        
        let pageContentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInit()
        
        setupNavBar()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

//MARK: - 设置UI界面
extension HomeViewController {
    
    fileprivate func setupInit() {
//        title = "首页"
        automaticallyAdjustsScrollViewInsets = false
    }
    
    fileprivate func setupNavBar() {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn);
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40.0, height: 40.0)
        
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highLightedImageName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highLightedImageName: "btn_search_clicked", size: size)
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highLightedImageName: "Image_scan_click", size: size)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highLightedImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highLightedImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highLightedImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
    fileprivate func setupUI() {
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}

extension HomeViewController: PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
