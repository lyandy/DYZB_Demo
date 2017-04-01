//
//  RoomShowViewController.h
//  DYZB
//
//  Created by 李扬 on 2017/3/31.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "SVProgressHUD+Andy.h"
#import "AndyStore.h"

@interface RoomShowViewController : UIViewController

@property (strong, nonatomic) UIButton *btnClose;

@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;

@property (nonatomic, copy) NSString *rtmpUrl;

- (void)setupAutoLayouts;

- (void)clearMoviePlayer;

- (void)didFinish;

@end
