//
//  LionPicLine.m
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionPicLine.h"

@interface LionPicLine ()

@property (strong, nonatomic) IBOutlet UIButton *imagePic1;

@property (strong, nonatomic) IBOutlet UIButton *imagePic2;

@property (strong, nonatomic) IBOutlet UIButton *imagePic3;

@property (strong, nonatomic) IBOutlet UIButton *imagePic4;

//
@property (strong, nonatomic) IBOutlet UIButton *wordLable1;

@property (strong, nonatomic) IBOutlet UIButton *wordLable2;

@property (strong, nonatomic) IBOutlet UIButton *wordLable3;

@property (strong, nonatomic) IBOutlet UIButton *wordLable4;

//  左边的图片

@property (nonatomic,strong)NSMutableArray * leftPicArray;

//  右边的文字
@property (nonatomic,strong)NSMutableArray * rightWordArray;

//  记录单词
@property (nonatomic,strong)NSMutableArray * allWords;

//  记录坐标
@property(nonatomic,strong) NSMutableArray * allPoint;

@property(nonatomic,strong) NSMutableArray * pointOne;
@property (nonatomic,strong)NSMutableArray * pointTwo;
@property (nonatomic,strong)NSMutableArray * pointThree;
@property (nonatomic,strong)NSMutableArray * pointFour;

// 记录点击答题

@property (nonatomic,strong)NSMutableArray * dramPic;

@property (nonatomic,strong)NSMutableArray * imageDraw;

@property (nonatomic,assign)BOOL isLeft;
@property (nonatomic,assign)BOOL isRight;

@property (nonatomic,assign)NSInteger rightCount;

@end

@implementation LionPicLine

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.leftPicArray = [NSMutableArray array];
    self.rightWordArray = [NSMutableArray array];
    self.pointOne = [NSMutableArray array];
    self.pointTwo = [NSMutableArray array];
    self.pointThree = [NSMutableArray array];
    self.pointFour = [NSMutableArray array];
    self.dramPic = [NSMutableArray array];
    self.imageDraw = [NSMutableArray array];
    
    _rightCount =0;
    _isLeft = NO;
    _isRight = NO;
}

- (void)setWordOne:(NSMutableArray *)wordOne
{
    _wordOne = wordOne;
    self.allWords = [NSMutableArray arrayWithArray:wordOne];
    self.leftPicArray = [NSMutableArray arrayWithObjects:self.imagePic1,self.imagePic2,self.imagePic3,self.imagePic4, nil];
    
    for (int i = 3; i >= 0 ; i--) {
        
        int count = arc4random()%(i+1);
        NSString * imageName = [_wordOne objectAtIndex:count];
       // NSString * picStr = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png" inDirectory:nil];
        UIButton * imageViewBtn =[self.leftPicArray objectAtIndex:i];
        [imageViewBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [_wordOne removeObject:imageName];
        
        [self addPoint:imageName center:imageViewBtn];
    }
    
    
    
}

- (void)setWordTow:(NSMutableArray *)wordTow
{

    _wordTow = wordTow;
    self.rightWordArray = [NSMutableArray arrayWithObjects:self.wordLable1,self.wordLable2,self.wordLable3,self.wordLable4, nil];
    for (int i = 3; i >= 0 ; i--) {
        
        int count = arc4random()%(i+1);
        NSString * word = [_wordTow objectAtIndex:count];
        // NSString * picStr = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png" inDirectory:nil];
        UIButton * imageViewBtn =[self.rightWordArray objectAtIndex:i];
        imageViewBtn.layer.borderColor = [UIColor blueColor].CGColor;
        imageViewBtn.layer.borderWidth = 2;
        [imageViewBtn setTitle:word forState:UIControlStateNormal];
        imageViewBtn.titleLabel.font = [UIFont systemFontOfSize:25];
        [_wordTow removeObject:word];
        [self addPoint:word center:imageViewBtn];
    }
    
}

- (void)addPoint:(NSString *)word center:(UIButton *)pointBt
{

    int i = 0;
    for (int k = 0 ; k<4; k++) {
        if ([word isEqualToString:[self.allWords objectAtIndex:k]]) {
            i = k;
            break;
        }
    }
    switch (i) {
        case 0:
            [self.pointOne addObject:pointBt];
            break;
        case 1:
             [self.pointTwo addObject:pointBt];
            break;
        case 2:
             [self.pointThree addObject:pointBt];
            break;
        case 3:
             [self.pointFour addObject:pointBt];
            break;
        default:
            break;
    }
 }

//  显示答案
- (void)showAnswer
{
    
    for (UIImageView * view in self.imageDraw) {
        [view removeFromSuperview];
    }
    
    [self.imageDraw removeAllObjects];
    [self showLineOnePoint:[[self.pointOne objectAtIndex:0] center] twoPoint:[[self.pointOne objectAtIndex:1] center]];
    [self showLineOnePoint:[[self.pointTwo objectAtIndex:0] center] twoPoint:[[self.pointTwo objectAtIndex:1] center]];
    [self showLineOnePoint:[[self.pointThree objectAtIndex:0] center] twoPoint:[[self.pointThree objectAtIndex:1] center]];
    [self showLineOnePoint:[[self.pointFour objectAtIndex:0] center] twoPoint:[[self.pointFour objectAtIndex:1] center]];
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
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.8,0.8,0.8, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), pointTwo.x, pointTwo.y);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
   //[self.imageDraw addObject:imageView];
    
    UIGraphicsEndImageContext();
}

#pragma mark --- 画线
- (void)showLineOnePoint2:(CGPoint)point twoPoint:(CGPoint)pointTwo
{
    
    
    
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIGraphicsBeginImageContext( imageView.frame.size);
    [self addSubview: imageView];
    [imageView.image drawInRect:CGRectMake(0, 0,  imageView.frame.size.width,  imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 4.0);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.8,0.8,0.8, 1.0);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), point.x, point.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), pointTwo.x, pointTwo.y);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
    [self.imageDraw addObject:imageView];
    
    UIGraphicsEndImageContext();
    
    _isLeft = NO;
    _isRight = NO;
}

//  左边触摸
- (IBAction)didClickLeftPic:(id)sender {

    UIButton * bnt = (UIButton *)sender;
    
    if ((self.dramPic.count == 1)&&_isRight == NO) {
        [self.dramPic removeAllObjects];
        _isRight = NO;
        _isLeft = NO;
        return;
    }
    
    if (!_isLeft) {
        [self.dramPic addObject:bnt];
        if (self.dramPic.count == 2) {
            [self drawLine:self.dramPic];
            [self.dramPic removeAllObjects];
            
            return;
        }
        _isLeft = YES;

    }

    
   
   }
//  右边触摸
- (IBAction)didClickRightWord:(id)sender {
    
    UIButton * bnt = (UIButton *)sender;
    
    if ((self.dramPic.count == 1)&&_isLeft == NO) {
        [self.dramPic removeAllObjects];
        _isRight = NO;
        _isLeft = NO;
        return;
    }
    
    if (!_isRight) {
        [self.dramPic addObject:bnt];
        if (self.dramPic.count == 2) {
            [self drawLine:self.dramPic];
            [self.dramPic removeAllObjects];
            return;
        }
         _isRight = YES;
    }
}

- (void)drawLine:(NSMutableArray *)arrBtn
{
    
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
    
    
    UIButton * bnt1 = [arrBtn objectAtIndex:0];
    UIButton * bnt2 = [arrBtn objectAtIndex:1];
    [self showLineOnePoint2:bnt1.center twoPoint:bnt2.center];
    bnt2.userInteractionEnabled = NO;
    bnt1.userInteractionEnabled = NO;
    if (self.rightCount == 4) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"right" object:nil];
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

@end
