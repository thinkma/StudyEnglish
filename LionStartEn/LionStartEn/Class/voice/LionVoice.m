//
//  LionVoice.m
//  SpeakVoice
//
//  Created by Apple on 14-8-28.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionVoice.h"
#import <AVFoundation/AVFoundation.h>
#import "MCSoundBoard.h"


@interface LionVoice ()<AVAudioPlayerDelegate>

@end



@implementation LionVoice

- (void)speakWord:(NSString *)word
{
    
    
    [MCSoundBoard addAudioAtPath:[[NSBundle mainBundle] pathForResource:word ofType:@"wav"] forKey:@"apple"];
    AVAudioPlayer *player = [MCSoundBoard audioPlayerForKey:@"apple"];
    player.numberOfLoops = 0;  // Endless
    [MCSoundBoard playAudioForKey:@"apple" fadeInInterval:0.3];
    
    return;
    
//  NSString *fileName = [[NSBundle mainBundle] pathForResource:@"banana.wav"
//                                                         ofType:nil];
//    NSURL *fileUrl = [NSURL fileURLWithPath:fileName];
//    NSError *error = nil;
//   //AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
////
//    if (!player) {
//        
//    } else {
//        [player setNumberOfLoops:0]; //默认为0，即播放一次就结束；如果设置为负值，则音频内容会不停的循环播放下去。
//        [player setDelegate:self];
//        [player play];
//    }
    
}
@end
