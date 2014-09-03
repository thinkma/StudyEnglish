//
//  LionPicLine.h
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LionPicLine : UIView

@property (nonatomic,strong)NSDictionary * subject;

@property (nonatomic,strong)NSMutableArray * wordOne;
@property (nonatomic,strong)NSMutableArray * wordTow;


- (void)showAnswer;

@end
