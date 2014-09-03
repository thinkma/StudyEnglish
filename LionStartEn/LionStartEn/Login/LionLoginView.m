//
//  LionLoginView.m
//  LionStartEn
//
//  Created by Apple on 14-8-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionLoginView.h"


@interface LionLoginView ()

@property (strong, nonatomic) IBOutlet UILabel *remiveText;


@end

@implementation LionLoginView

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

    self.remiveText.hidden = YES;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)didClickSubmitAction:(id)sender {
   self.remiveText.hidden = YES;
    if ([self.userTextField.text isEqualToString:@"ma"]&&[self.pwtextField.text isEqualToString:@"123"]) {
        if (_login) {
            _login();
        }
    }else{
    
        self.remiveText.hidden = NO;

        
    }
    
}
@end
