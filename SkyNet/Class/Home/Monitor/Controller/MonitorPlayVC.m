//
//  MonitorPlayVC.m
//  SkyNet
//
//  Created by 魏乔森 on 2017/9/28.
//  Copyright © 2017年 xrg. All rights reserved.
//

#import "MonitorPlayVC.h"
#import "MDFlipCollectionView.h"
#import "MDMultipleSegmentView.h"
#import "PTZControlVC.h"
#import "PlayBackVC.h"
#import "PressSpeakVC.h"
#import <AVFoundation/AVFoundation.h>
@interface MonitorPlayVC ()<MDMultipleSegmentViewDeletegate,
MDFlipCollectionViewDelegate>
@property (nonatomic, strong) MDMultipleSegmentView *segView;
@property (nonatomic, strong) MDFlipCollectionView *collectView;
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation MonitorPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频播放";
    [self setNavBackButtonImage:ImageNamed(@"back")];
    [self setupPlayView];
    [self creatSegmentView];
}

- (void)setupPlayView {
    //[self.player play];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@""]];
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    playerLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 280);
    [self.view.layer addSublayer:playerLayer];
}

-(AVPlayer *)player {
    if (_player == nil) {
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo-transcode/169_1905b5de25b3bf55e76ea888973a94a7_2.mp4"]];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        playerLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 280);
        [self.view.layer addSublayer:playerLayer];
    }
    return _player;
}

- (void)creatSegmentView{
    [self.view addSubview:self.segView];
    PTZControlVC * ptzVC =[[PTZControlVC alloc]init];
    ptzVC.view.backgroundColor =[UIColor whiteColor];
    
    PlayBackVC * playBackVC = [[PlayBackVC alloc]init];
    playBackVC.view.backgroundColor=[UIColor whiteColor];
    
    PressSpeakVC *speakVC = [[PressSpeakVC alloc] init];
    speakVC.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:ptzVC];
    [self addChildViewController:playBackVC];
    [self addChildViewController:speakVC];
    NSArray *arr = @[ptzVC,playBackVC,speakVC];
    _collectView = [[MDFlipCollectionView alloc] initWithFrame:CGRectMake(0,
                                                                          _segView.bottom,
                                                                          SCREEN_WIDTH,
                                                                          SCREEN_HEIGHT-_segView.bottom-NavigationBar_HEIGHT-STATUS_BAR_HEIGHT) withArray:arr];
    _collectView.delegate = self;
    [self.view addSubview:_collectView];
}
- (MDMultipleSegmentView *)segView {
    if (!_segView) {
        _segView = [[MDMultipleSegmentView alloc] init];
        _segView.delegate =  self;
        _segView.frame = CGRectMake(0, 280, SCREEN_WIDTH, 44);
        _segView.items = @[@"PTZ控制",@"回放",@"对讲"];
    }
    return _segView;
}

- (void)changeSegmentAtIndex:(NSInteger)index
{
    [_collectView selectIndex:index];
}


- (void)flipToIndex:(NSInteger)index
{
    [_segView selectIndex:index];
}



@end
