//
//  LionVoiceJudge.m
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionVoiceJudge.h"
#import "LionVoice.h"



@interface LionVoiceJudge ()
{

    LionVoice * speak;
}

@property (strong, nonatomic) IBOutlet UIImageView *showImagePic;


@end


@implementation LionVoiceJudge

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

}
- (void)setWords:(NSString *)words
{
    _words = words;
    
//    NSString * str = [NSString stringWithFormat:@"%@.png",words];
    
   // NSString * str = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"];
    
    [self.showImagePic setImage:[UIImage imageNamed:words]];
    
}

- (void)setWordOne:(NSMutableArray *)wordOne
{
    _wordOne = wordOne;
    speak = [[LionVoice alloc] init];
    
    [speak speakWord:[_wordOne objectAtIndex:0]];

    
}
- (IBAction)sayYes:(id)sender {

    if ([[_wordOne objectAtIndex:0] isEqualToString:_words]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"right" object:nil];
    }else{
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil];
    }
    
}
- (IBAction)sayNO:(id)sender {
    if ([[_wordOne objectAtIndex:0] isEqualToString:_words]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil];
    }else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"right" object:nil];
    }
    
}

- (IBAction)sayword:(id)sender {
    
   
    [speak speakWord:[_wordOne objectAtIndex:0]];

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
