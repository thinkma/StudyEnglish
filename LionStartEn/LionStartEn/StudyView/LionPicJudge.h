//
//  LionPicJudge.h
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LionPicJudge : UIView

@property (nonatomic,strong)NSDictionary * subject;

@property (nonatomic,strong)NSMutableArray * words;
@property (nonatomic,copy)NSString * wordimage;


- (void)shwoAnswer;
@end
