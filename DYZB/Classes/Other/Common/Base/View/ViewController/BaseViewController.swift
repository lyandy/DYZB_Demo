//
//  BaseViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/3/30.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView: UIView?

    fileprivate lazy var animationImageView: UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!];
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension BaseViewController {
    func setupUI() {
        
        contentView?.isHidden = true
        
        view.addSubview(animationImageView)
        
        animationImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250.0, g: 250.0, b: 250.0)
    }
    
    func loadDidFinished() {
        animationImageView.stopAnimating()
        animationImageView.isHidden = true
        contentView?.isHidden = false
    }
}
