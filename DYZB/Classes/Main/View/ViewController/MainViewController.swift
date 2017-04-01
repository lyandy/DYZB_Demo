//
//  MainViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/16.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildVCs()
    }
}

extension MainViewController {
    fileprivate func setupChildVCs() {
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }
    
    private func addChildVC(storyName : String)
    {
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
    }
}

