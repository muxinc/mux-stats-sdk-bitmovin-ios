//
//  PlayerViewController.m
//  DemoApp_objc
//
//  Created by Stephanie Zuñiga on 17/3/22.
//

#import "PlayerViewController.h"

@import MUXSDKBitmovin;
@import BitmovinPlayer;
@import MuxCore;

NSString *const videoURL = @"https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8";
NSString *const playerName = @"iOS BitmovinPlayer";
NSString *const environmentKey = @"YOUR_ENV_KEY";

@interface PlayerViewController () {
    BMPPlayerView *_playerView;
}
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.blackColor;
    
    [self setupBitmovinPlayer];
    [self setupMUX];
}

- (void) setupBitmovinPlayer {
    // Define needed resources'
    NSURL *streamURL = [[NSURL alloc] initWithString:videoURL];
    if (!streamURL) {
        return;
    }
    
    // Create player configuration
    BMPPlayerConfig *playerConfig = [BMPPlayerConfig new];

    // Create player based on player configuration
    id<BMPPlayer> player = [BMPPlayerFactory createWithPlayerConfig:playerConfig];
    
    // Create player view and pass the player instance to it
    _playerView = [[BMPPlayerView alloc] initWithPlayer:player frame:CGRectZero];
    if(!_playerView) {
        return;
    }
    
    _playerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _playerView.frame = self.view.bounds;

    [self.view addSubview:_playerView];
    [self.view bringSubviewToFront:_playerView];

    // Create source config
    BMPSourceConfig *sourceConfig = [[BMPSourceConfig alloc] initWithUrl:streamURL type: BMPSourceTypeHls];
    
    [player loadSourceConfig:sourceConfig];
}

- (void) setupMUX{
    MUXSDKCustomerPlayerData *playerData = [[MUXSDKCustomerPlayerData alloc] initWithPropertyKey:environmentKey];
    [playerData setPlayerName: playerName];
    
    MUXSDKCustomerVideoData *videoData = [MUXSDKCustomerVideoData new];
    videoData.videoTitle = @"Title Video Bitmovin Objc";
    videoData.videoId = @"sintel";
    
    MUXSDKCustomerViewData *viewData= [[MUXSDKCustomerViewData alloc] init];
    viewData.viewSessionId = @"my session id";
    
    MUXSDKCustomData *customData = [[MUXSDKCustomData alloc] init];
    [customData setCustomData1:@"Bitmovin test"];
    [customData setCustomData2:@"Custom Data 2"];

    MUXSDKCustomerViewerData *viewerData = [[MUXSDKCustomerViewerData alloc] init];
    viewerData.viewerApplicationName = @"MUX Bitmovin DemoApp Objc";
    
    MUXSDKCustomerData *customerData = [[MUXSDKCustomerData alloc] initWithCustomerPlayerData:playerData
                                                                                    videoData:videoData
                                                                                     viewData:viewData
                                                                                   customData:customData
                                                                                   viewerData:viewerData];
    
    [MUXSDKStats monitorPlayerWithPlayer:_playerView playerName:playerName customerData:customerData automaticErrorTracking:YES];
}

- (void)dealloc {
    [_playerView.player destroy];
}

@end
