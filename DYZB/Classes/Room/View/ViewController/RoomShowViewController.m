//
//  RoomShowViewController.m
//  DYZB
//
//  Created by 李扬 on 2017/3/31.
//  Copyright © 2017年 andyshare. All rights reserved.
//

#import "RoomShowViewController.h"
#import "AndyConst.h"

@interface RoomShowViewController ()

@end

@implementation RoomShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInit];
    
    [self setupSubViwes];
    
    [self setupAutoLayouts];
    
    [self initObserver];
}

- (NSString *)rtmpUrl
{
    NSString *rtmpServerIP = (NSString *)[[AndyUserDefaultsStore sharedUserDefaultsStore] getValueForKey:KEY_RTMP_SERVER_IP DefaultValue:RTMP_SERVER_IP_DEFAULT];
    NSString *roomId = (NSString *)[[AndyUserDefaultsStore sharedUserDefaultsStore] getValueForKey:KEY_SHOW_ROOM_ID DefaultValue:SHOW_ROOM_ID_DEFAULT];
    
    return [NSString stringWithFormat:@"rtmp://%@:1935/rtmplive/%@",rtmpServerIP,roomId];
}

- (IJKFFMoviePlayerController *)moviePlayer
{
    if (_moviePlayer == nil)
    {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
        
        // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
        [options setPlayerOptionIntValue:29.97 forKey:@"r"];
        // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
        [options setPlayerOptionIntValue:512 forKey:@"vol"];
//        NSString *rtmpUrl = (NSString *)[[AndyUserDefaultsStore sharedUserDefaultsStore] getValueForKey:RTMP_IP_KEY DefaultValue:nil];
        _moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.rtmpUrl withOptions:options];
        // 填充fill
        _moviePlayer.scalingMode = IJKMPMovieScalingModeNone;
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
        _moviePlayer.shouldAutoplay = NO;
        // 默认不显示直播帧率信息
        _moviePlayer.shouldShowHudView = NO;
        
        [_moviePlayer prepareToPlay];
    }
    return _moviePlayer;
}

- (UIButton *)btnClose
{
    if (_btnClose == nil)
    {
        UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnClose setImage:[UIImage imageNamed:@"talk_close_40x40_"] forState:UIControlStateNormal];
        
        [btnClose addTarget:self action:@selector(btnClose_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        _btnClose = btnClose;
    }
    return _btnClose;
}

- (void)setupInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD andy_ShowLoadingWithStatus:@"正在获取视频流，请稍后..."];
}

- (void)setupSubViwes
{
    [self.view addSubview:self.btnClose];
    
    [self.view insertSubview:self.moviePlayer.view belowSubview:self.btnClose];
}

- (void)setupAutoLayouts
{
    CGFloat commonMargin = 25;
    
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-commonMargin);
        make.top.mas_equalTo(self.view.mas_top).offset(commonMargin);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.moviePlayer.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom).priorityLow();
        make.right.mas_equalTo(self.view.mas_right);
    }];
}

- (void)btnClose_Click:(UIButton *)sender
{
    [self clearMoviePlayer];
    
    [SVProgressHUD dismiss];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearMoviePlayer
{
    if (self.moviePlayer != nil)
    {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        [self.moviePlayer.view removeFromSuperview];
    }
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)stateDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0)
    {
        if (!self.moviePlayer.isPlaying)
        {
            [self.moviePlayer play];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled)
    {
        // 网速不佳, 自动暂停状态
        [SVProgressHUD andy_ShowLoadingWithStatus:@"正在获取视频流，请稍后..."];
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了
    //    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled)
    //    {
    [SVProgressHUD andy_ShowInfoWithStatus:@"直播结束"];
    
    [self btnClose_Click:self.btnClose];
    
//    return;
    //}
}


- (void)dealloc
{
    [SVProgressHUD dismiss];
    
    NSLog(@"拉流控制器 已销毁");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
