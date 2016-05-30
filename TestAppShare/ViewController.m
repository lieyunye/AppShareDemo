//
//  ViewController.m
//  TestAppShare
//
//  Created by lieyunye on 5/26/16.
//  Copyright © 2016 lieyunye. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    AVPlayerLayer *_playerLayer;
}

@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic, strong)AVURLAsset *videoURLAsset;
@property (nonatomic, strong)AVPlayerItem *videoPlayItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _player = [[AVPlayer alloc] init];
    _playerLayer = [[AVPlayerLayer alloc] init];
    _playerLayer.player = _player;
    [self.view.layer addSublayer:_playerLayer];
    _playerLayer.frame = self.view.bounds;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *fileName = [[NSUserDefaults standardUserDefaults] objectForKey:@"fileName"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@",cacheDir,@"Inbox",fileName];
    
    BOOL ret = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (ret) {
        if (filePath) {
            _videoURLAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:filePath] options:nil];
        }else {
            NSLog(@"kkkkkk");
        }
        if (_videoURLAsset) {
            _videoPlayItem  = [AVPlayerItem playerItemWithAsset:_videoURLAsset];
            NSArray *requestedKeys = [NSArray arrayWithObjects:@"playable", nil];
            __weak typeof(self) weakSelf = self;
            [_videoURLAsset loadValuesAsynchronouslyForKeys:requestedKeys completionHandler:^{
                NSError *error = nil;
                AVKeyValueStatus keyStatus = [weakSelf.videoURLAsset statusOfValueForKey:@"playable" error:&error];
                if (keyStatus == AVKeyValueStatusFailed || weakSelf.videoURLAsset.playable == NO) {
                    NSLog(@"AVKeyValueStatusFailed %@",error);
                    
                }else {
                    [weakSelf.player replaceCurrentItemWithPlayerItem:weakSelf.videoPlayItem];
                    [weakSelf.player play];
                }
                
            }];
        }else {
            NSLog(@"mmmmmm");
            
        }
    }
}
@end
