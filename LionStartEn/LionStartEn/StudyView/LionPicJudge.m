//
//  LionPicJudge.m
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionPicJudge.h"


@interface LionPicJudge ()

@property (strong, nonatomic) IBOutlet UIImageView *showImagePic;

@property (strong, nonatomic) IBOutlet UIButton *word1;

@property (strong, nonatomic) IBOutlet UIButton *word2;

@property (strong, nonatomic) IBOutlet UIButton *word3;

@property (strong, nonatomic) IBOutlet UIButton *word4;

@property (strong, nonatomic) IBOutlet UIButton *word5;

@property (strong, nonatomic) IBOutlet UIButton *word6;
@property (nonatomic,assign)NSInteger num;

@property (nonatomic,strong)NSMutableArray * sumBtn;

@property (nonatomic,strong)UIButton * oldButton;

@property (nonatomic,assign)BOOL isOne;

@end

@implementation LionPicJudge

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

    self.num = -1;
    
}
- (void)setWords:(NSMutableArray *)words
{
    _words = words;
    
    self.sumBtn = [NSMutableArray arrayWithObjects:self.word1,self.word2,self.word3,self.word4,self.word5,self.word6, nil];
    int k ;
    for (int i =0;i<6;i++) {
        UIButton * brn = [_sumBtn objectAtIndex:i];
        if (i==5) {
            k=0;
        }else{
         k = arc4random()%(5-i);
        }
         NSString *s = [_words objectAtIndex:k];
        [_words removeObject:s];
        [brn setTitle:s forState:UIControlStateNormal];
        if ([s isEqualToString:_wordimage]) {
            self.num = i;
        }

//        
//        UIButton * brn = [_sumBtn objectAtIndex:i];
//        if ((5-i)==0) {
//            k = 0;
//        }else{
//            
//          k = arc4random()%(5-i);
//            
//        }
//     
//        NSString *s = [_words objectAtIndex:k];
//        [_words removeObject:s];
//        [brn setTitle:s forState:UIControlStateNormal];
//        if (![_words containsObject:self.wordimage]) {
//            
//            if (self.num>=0) {
//                return;
//            }
//            self.num = i;
//        }
    }
}

- (void)shwoAnswer
{

    UIButton * btn = [self.sumBtn objectAtIndex:self.num];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2;

}

- (void)setWordimage:(NSString *)wordimage
{

    _wordimage = wordimage;
    
    self.showImagePic.image = [UIImage imageNamed:_wordimage];
    
}

- (IBAction)didClickWord:(id)sender {
    
    if (self.oldButton) {
        _oldButton.layer.borderWidth = 0;
    }
    UIButton * bnt = (UIButton *)sender;
    bnt.layer.borderWidth = 2;
    bnt.layer.borderColor = [UIColor yellowColor].CGColor;
    self.oldButton = bnt;
UIButton * btn = [self.sumBtn objectAtIndex:self.num];
    if (!_isOne) {
        if ([btn isEqual:bnt]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"right" object:nil];
        }else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil];
            
        }
        _isOne = YES;
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
