//
//  PieChartView.h
//  PeiViewTest
//
//  Created by Eric Yuen on 11-8-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PieChartView : UIView {
    
    float               mZeroAngle;
    NSMutableArray     *mThetaArray;
}

@property (nonatomic)         float           mZeroAngle;


- (void)toSetBoardColor:(UIColor *)color;
- (void)tosetValue:(CGFloat)value;

@end