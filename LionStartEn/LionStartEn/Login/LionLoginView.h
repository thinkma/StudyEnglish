//
//  LionLoginView.h
//  LionStartEn
//
//  Created by Apple on 14-8-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LoginBlock) (void);

@interface LionLoginView : UIView
@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwtextField;

- (IBAction)didClickSubmitAction:(id)sender;

@property (nonatomic,copy)LoginBlock login;

@end
