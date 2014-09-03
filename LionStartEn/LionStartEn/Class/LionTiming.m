//
//  LionTiming.m
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionTiming.h"

@interface LionTiming ()
{
    NSTimer *timer;
    NSInteger time;
    
}
@end

@implementation LionTiming



- (void)startTime
{

    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(calculationTime) userInfo:nil repeats:YES];
    time = 0;
    [timer fire];
}

- (void)calculationTime
{

    time++;
    
}

/**
 *  时间需要保存，再次启动的时候调用这个时间继续走
 */
- (void)stopTime
{
    
    [timer invalidate];
    timer = nil;
    
}

@end
