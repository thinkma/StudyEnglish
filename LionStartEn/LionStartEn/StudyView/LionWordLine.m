//
//  LionWordLine.m
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionWordLine.h"
#import <QuartzCore/QuartzCore.h>

@interface LionWordLine ()

@property (strong, nonatomic) IBOutlet UIButton *btnOneWord;

@property (strong, nonatomic) IBOutlet UIButton *btnTwoWord;
@property (strong, nonatomic) IBOutlet UIButton *btnThreeWord;
@property (strong, nonatomic) IBOutlet UIButton *btnFourWord;

//
@property (strong, nonatomic) IBOutlet UIButton *btnFiveWord;

@property (strong, nonatomic) IBOutlet UIButton *btnSixWord;
@property (strong, nonatomic) IBOutlet UIButton *btnsevenWord;
@property (strong, nonatomic) IBOutlet UIButton *btnHeightWord;

//  点击按钮事件
- (IBAction)didbtnAction:(id)sender;
- (IBAction)didBtnRightAction:(id)sender;



@property(nonatomic,strong) NSMutableArray * allPoint;

@property(nonatomic,strong) NSMutableArray * pointOne;
@property (nonatomic,strong)NSMutableArray * pointTwo;
@property (nonatomic,strong)NSMutableArray * pointThree;
@property (nonatomic,strong)NSMutableArray * pointFour;

//  左边的按钮

@property (nonatomic,strong)NSMutableArray * arrRightBtn;
@property (nonatomic,strong)NSMutableArray * arrLeftBtn;


// 是否画线

@property (nonatomic,assign)BOOL isLeftDraw;
@property (nonatomic,assign)BOOL isRightDraw;

/**
 画一条线保存的点
 */
@property (nonatomic,strong)NSMutableArray *drawPoint;

//  画板
//@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)NSMutableArray * imageDraw;

@property (nonatomic,strong)NSMutableArray * tempArray;
@property (nonatomic,strong)NSMutableArray * temoArray1;


@property (nonatomic,assign)NSInteger rightCount;
@end

@implementation LionWordLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)awakeFromNib
{

    self.pointOne = [NSMutableArray array];
    self.pointTwo = [NSMutableArray array];
    self.pointThree = [NSMutableArray array];
    self.pointFour = [NSMutableArray array];
    self.drawPoint = [NSMutableArray array];
    self.imageDraw = [NSMutableArray array];
    
    _isLeftDraw = NO;
    _isRightDraw = NO;
    self.rightCount = 0;
    //  画板

    
    
}

- (void)setWordOne:(NSMutableArray *)wordOne
{
    _wordOne = wordOne;
    self.tempArray = [NSMutableArray arrayWithArray:wordOne];
   self.arrLeftBtn = [NSMutableArray arrayWithObjects:self.btnOneWord,self.btnTwoWord,self.btnThreeWord,self.btnFourWord,nil];
    for (int i =3; i>=0; i--) {
        UIButton * btn = [_arrLeftBtn objectAtIndex:i];
        
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor greenColor].CGColor;
        btn.titleLabel.textColor = [UIColor blackColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:22];
        if (i == 0) {
            NSString * word = [_wordOne objectAtIndex:i];
            [btn setTitle:word forState:UIControlStateNormal];
            [self addpoint:word centerPoint:btn];

            return;
        }
        int num = arc4random()%(i+1);
        NSString * word = [_wordOne objectAtIndex:num];
        [btn setTitle:word forState:UIControlStateNormal];
        [_wordOne removeObject:word];
        [self addpoint:word centerPoint:btn];


    }
}

- (void)setWordTow:(NSMutableArray *)wordTow
{

    _wordTow = wordTow;
    self.temoArray1 = [NSMutableArray arrayWithArray:wordTow];
    self.arrRightBtn = [NSMutableArray arrayWithObjects:self.btnFiveWord,self.btnSixWord,self.btnsevenWord,self.btnHeightWord,nil];
    for (int i =3; i>=0; i--) {
        UIButton * btn = [_arrRightBtn objectAtIndex:i];
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.titleLabel.textColor = [UIColor blackColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:22];
        if (i == 0) {
            NSString * word = [_wordTow objectAtIndex:i];
            [btn setTitle:word forState:UIControlStateNormal];
            [self addpoint:word centerPoint:btn];

            return;
        }
        int num = arc4random()%(i+1);
        NSString * word = [_wordTow objectAtIndex:num];
        [btn setTitle:word forState:UIControlStateNormal];
        [_wordTow removeObject:word];
        
        [self addpoint:word centerPoint:btn];

    }
    
}

- (void)addpoint:(NSString *)word centerPoint:(UIButton *)center
{
    int num = 0;
    
    for(int i =0 ;i<self.tempArray.count;i++){
        if ([word isEqualToString:[self.tempArray objectAtIndex:i]]) {
            num = i;
            break;
        }
        
    }
    for(int i =0 ;i<self.temoArray1.count;i++){
        if ([word isEqualToString:[self.temoArray1 objectAtIndex:i]]) {
            num = i;
            break;
        }
        
    }
    
    switch (num) {
        case 0:
            if (![self.pointOne containsObject:center]) {
                [self.pointOne addObject:center];
            }
           break;
        case 1:
            if (![self.pointTwo containsObject:center]) {
                [self.pointTwo addObject:center];
            }
                      break;
        case 2:
            if (![self.pointThree containsObject:center]) {
                [self.pointThree addObject:center];
            }
            break;
        case 3:
            if (![self.pointFour containsObject:center]) {
                [self.pointFour addObject:center];
            }
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)didbtnAction:(id)sender {

    UIButton * btn = (UIButton *)sender;
//  如果点击同一个边两次 则重新连线
    if ((self.drawPoint.count == 1) &&(_isRightDraw == NO)) {
        [self.drawPoint removeAllObjects];
        _isRightDraw = NO;
        _isLeftDraw = NO;
        return;
    }
    if (!_isLeftDraw) {
        [self.drawPoint addObject:btn];
        _isLeftDraw = YES;
    }
    if (self.drawPoint.count == 2) {
        [self drawLine:self.drawPoint];
        return;
    }
}

- (IBAction)didBtnRightAction:(id)sender {
    if ((self.drawPoint.count == 1) &&(_isLeftDraw == NO)) {
        [self.drawPoint removeAllObjects];
        _isRightDraw = NO;
        _isLeftDraw = NO;
        return;
    }
    UIButton * btn = (UIButton *)sender;
    if (!_isRightDraw) {
        [self.drawPoint addObject:btn];
        _isRightDraw = YES;
    }
    if (self.drawPoint.count == 2) {
        [self drawLine:self.drawPoint];
        return;
    }

}

- (void)drawLine:(NSMutableArray *)arrBtn
{


    CGPoint center1 = [[arrBtn objectAtIndex:0] center];
    CGPoint center2 = [[arrBtn objectAtIndex:1] center];

//  判断答案是否一样
    
    if ([self.pointOne containsObject:[arrBtn objectAtIndex:0]]) {
        
        if ([self.pointOne containsObject:[arrBtn objectAtIndex:1]]) {
            self.rightCount ++;
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil];
        }
    }
    
    if ([self.pointTwo containsObject:[arrBtn objectAtIndex:0]]) {
        
        if ([self.pointTwo containsObject:[arrBtn objectAtIndex:1]]) {
            self.rightCount ++;
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil];
        }
    }
    
    if ([self.pointThree containsObject:[arrBtn objectAtIndex:0]]) {
        
        if ([self.pointThree containsObject:[arrBtn objectAtIndex:1]]) {
            self.rightCount ++;
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil];
        }
    }
    
    if ([self.pointFour containsObject:[arrBtn objectAtIndex:0]]) {
        
        if ([self.pointFour containsObject:[arrBtn objectAtIndex:1]]) {
            self.rightCount ++;
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil];
        }
    }
    UIButton * btn1 = [arrBtn objectAtIndex:0];
    btn1.userInteractionEnabled = NO;
    UIButton * btn2 = [arrBtn objectAtIndex:1];
    btn2.userInteractionEnabled = NO;
    [self showLineOnePoint:center1 twoPoint:center2];
    NSLog(@"坏西安");
    [self.drawPoint removeAllObjects];
    _isRightDraw = NO;
    _isLeftDraw = NO;
    
    if (self.rightCount == 4) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"right" object:nil];
    }
}

#pragma mark --- 画线
- (void)showLineOnePoint:(CGPoint)point twoPoint:(CGPoint)pointTwo
{

   
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIGraphicsBeginImageContext( imageView.frame.size);
    [self addSubview: imageView];
    [imageView.image drawInRect:CGRectMake(0, 0,  imageView.frame.size.width,  imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 4.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1,0.1,0.1, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), pointTwo.x, pointTwo.y);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
     imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    [self.imageDraw addObject:imageView];
    UIGraphicsEndImageContext();
    
//
    if (self.imageDraw.count == 4) {
        
    }
}

- (void)showLineOnePoint2:(CGPoint)point twoPoint:(CGPoint)pointTwo
{
    
    
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIGraphicsBeginImageContext( imageView.frame.size);
    [self addSubview: imageView];
    [imageView.image drawInRect:CGRectMake(0, 0,  imageView.frame.size.width,  imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 4.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1,0.1,0.1, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), pointTwo.x, pointTwo.y);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
}

#pragma mark ----- 画正确的线
- (void)showrightLine
{
    
   
    [self showLineOnePoint2:[[self.pointOne objectAtIndex:0] center] twoPoint:[[self.pointOne objectAtIndex:1] center]];
     [self showLineOnePoint2:[[self.pointTwo objectAtIndex:0] center] twoPoint:[[self.pointTwo objectAtIndex:1] center]];
     [self showLineOnePoint2:[[self.pointThree objectAtIndex:0] center] twoPoint:[[self.pointThree objectAtIndex:1] center]];
     [self showLineOnePoint2:[[self.pointFour objectAtIndex:0] center] twoPoint:[[self.pointFour objectAtIndex:1] center]];
}

// 撤销
- (void)correctLine
{
    UIImageView * image =[self.imageDraw lastObject];
    [self.imageDraw removeLastObject];
    [image removeFromSuperview];
}

- (void)removeAllLine{


    for (UIImageView * image in self.imageDraw) {
        [image removeFromSuperview];
    }

}
@end
