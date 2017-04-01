//
//  RoomLiveConfigViewController.swift
//  DYZB
//
//  Created by 李扬 on 2017/4/1.
//  Copyright © 2017年 andyshare. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

private let kMargin: CGFloat = 30.0
private let kTextFieldW: CGFloat = 150.0

class RoomLiveConfigViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var rtmpServerLabel: UILabel!
    
    @IBOutlet weak var showRoomLabel: UILabel!
    
    @IBOutlet weak var pushRTMPLabel: UILabel!
    
    @IBOutlet weak var rtmpServerTextField: UITextField!
    
    @IBOutlet weak var showRoomTextField: UITextField!
    
    @IBOutlet weak var pushRTMPTextField: UITextField!
    
    @IBOutlet weak var btnStatPush: UIButton!
    
    @IBOutlet weak var btnSaveConfig: UIButton!
    
    fileprivate var isPush: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInit()
        
        setupAutoLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if (!isPush)
        {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        isPush = false
        
        view.endEditing(true)
    }
    
}

extension RoomLiveConfigViewController {
    
    fileprivate func setupInit() {
        
        rtmpServerTextField.text = AndyUserDefaultsStore.shared().getValueForKey(KEY_RTMP_SERVER_IP, defaultValue: RTMP_SERVER_IP_DEFAULT) as Any? as? String
        showRoomTextField.text = AndyUserDefaultsStore.shared().getValueForKey(KEY_SHOW_ROOM_ID, defaultValue: SHOW_ROOM_ID_DEFAULT) as Any? as? String
        pushRTMPTextField.text = AndyUserDefaultsStore.shared().getValueForKey(KEY_PUSH_RTMP_ROOM_ID, defaultValue: PUSH_RTMP_ROOM_ID_DEFAULT) as Any? as? String
    }
    
    fileprivate func setupAutoLayouts() {
        rtmpServerLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(kMargin)
            make.top.equalTo(view.snp.top).offset(kMargin * 3)
        }
        
        showRoomLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rtmpServerLabel.snp.left)
            make.top.equalTo(rtmpServerLabel.snp.bottom).offset(kMargin)
        }
        
        pushRTMPLabel.snp.makeConstraints { (make) in
            make.left.equalTo(showRoomLabel.snp.left)
            make.top.equalTo(showRoomLabel.snp.bottom).offset(kMargin)
        }
        
        rtmpServerTextField.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(-kMargin)
            make.centerY.equalTo(rtmpServerLabel.snp.centerY)
            make.width.equalTo(kTextFieldW)
        }
        
        showRoomTextField.snp.makeConstraints { (make) in
            make.right.equalTo(rtmpServerTextField.snp.right)
            make.centerY.equalTo(showRoomLabel.snp.centerY)
            make.width.equalTo(rtmpServerTextField.snp.width)
        }
        
        pushRTMPTextField.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(-kMargin)
            make.centerY.equalTo(pushRTMPLabel.snp.centerY)
            make.width.equalTo(showRoomTextField.snp.width)
        }
        
        btnStatPush.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.centerX).offset(kMargin)
            make.top.equalTo(pushRTMPTextField.snp.bottom).offset(kMargin)
        }
        
        btnSaveConfig.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp.centerX).offset(-kMargin)
            make.top.equalTo(btnStatPush.snp.top)
        }
    }
    
    @IBAction func btnStartPushClick(_ sender: Any) {
        
        isPush = true
        
        view.endEditing(true)
        
        saveConfig()
        
        let roomPushRTMPVC = RoomPushRTMPViewController()
        present(roomPushRTMPVC, animated: true, completion: nil)
    }

    @IBAction func btnSaveConfigClick(_ sender: Any) {
        
        saveConfig()
        
        SVProgressHUD.andy_ShowSuccess(withStatus: "配置信息已保存")
    }
    
    private func saveConfig() {
        AndyUserDefaultsStore.shared().setOrUpdateValue(rtmpServerTextField.text, forKey: KEY_RTMP_SERVER_IP)
        AndyUserDefaultsStore.shared().setOrUpdateValue(showRoomTextField.text, forKey: KEY_SHOW_ROOM_ID)
        AndyUserDefaultsStore.shared().setOrUpdateValue(pushRTMPTextField.text, forKey: KEY_PUSH_RTMP_ROOM_ID)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

