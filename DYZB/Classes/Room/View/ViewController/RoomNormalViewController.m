//
//  RoomNormalViewController.m
//  DYZB
//
//  Created by 李扬 on 2017/3/31.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import "RoomNormalViewController.h"
#import "UIView+Andy.h"
#import "AndyConst.h"

@interface RoomNormalViewController () <UIGestureRecognizerDelegate>

@end

@implementation RoomNormalViewController: RoomShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    super.btnClose.hidden = YES;

}

- (NSString *)rtmpUrl
{
    NSString *rtmpServerIP = (NSString *)[[AndyUserDefaultsStore sharedUserDefaultsStore] getValueForKey:KEY_RTMP_SERVER_IP DefaultValue:RTMP_SERVER_IP_DEFAULT];
    
    return [NSString stringWithFormat:@"rtmp://%@:1935/rtmplive/%@",rtmpServerIP, GAME_ROOM_ID_DEFAULT];
}

- (void)setupAutoLayouts
{
    [super setupAutoLayouts];
    
    [super.moviePlayer.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(super.view.andy_Width * 9.0 / 16.0);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了
    //    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled)
    //    {
    [SVProgressHUD andy_ShowInfoWithStatus:@"直播结束"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [super clearMoviePlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
