//
//  LionThridTableViewCell.m
//  LionStartEn
//
//  Created by Apple on 14-8-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionThridTableViewCell.h"
#import "PieChartView.h"

@interface LionThridTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLable;




@end

@implementation LionThridTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   
    if (_isSelect) {
        self.titleLable.textColor = [UIColor redColor];
    }else{
        self.titleLable.textColor = [UIColor blackColor];
    }
    // Configure the view for the selected state
}



- (void)setDic:(NSDictionary *)dic
{

    _dic = dic;
    
    CGFloat px = 104;
    CGFloat py = 5;
    CGFloat pw = 40;
    CGFloat ph = 40;
//
    PieChartView* pieView = [[PieChartView alloc] initWithFrame:CGRectMake(px,py,pw,ph)];
    
    if (self.rows%3== 0) {
        [pieView toSetBoardColor:[UIColor redColor]];

    }if (self.rows%3==1) {
        [pieView toSetBoardColor:[UIColor purpleColor]];
    }if (self.rows%3==2) {
        [pieView toSetBoardColor:[UIColor blueColor]];

    }
    
    
    NSInteger num = [[dic objectForKey:@"item2"] intValue];
    [pieView tosetValue:num];

    


    [self.contentView addSubview:pieView];
    
//    UIView * imageView = [[UIView alloc] initWithFrame:CGRectMake(px,py,pw,ph)];
//    
//    imageView.backgroundColor = [UIColor redColor];
//    imageView.layer.cornerRadius = 39;
//    imageView.layer.masksToBounds = YES;
//    
//    [self.contentView addSubview:imageView];
    
    self.titleLable.text = [dic objectForKey:@"item1"];
    self.titleLable.font = [UIFont systemFontOfSize:27];
    
}

@end
