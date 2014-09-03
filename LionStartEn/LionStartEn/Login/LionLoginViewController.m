//
//  LionLoginViewController.m
//  LionStartEn
//
//  Created by Apple on 14-8-20.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionLoginViewController.h"
#import "LionLoginView.h"
#import "LionStartViewController.h"

@interface LionLoginViewController ()

@end

@implementation LionLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title  = @"登陆";
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil];
    
    LionLoginView * loginView = [views objectAtIndex:0];
    
    loginView.login = ^(void){
    
        LionStartViewController * rootVc = [[LionStartViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:rootVc];
        
        [self presentViewController:nvc animated:YES completion:^{
            
        }];
        
    };
    
    [self.view addSubview:loginView];
    
    
    loginView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-100);

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
