//
//  LionSettingViewController.m
//  LionStartEn
//
//  Created by Apple on 14-8-30.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionSettingViewController.h"

@interface LionSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LionSettingViewController

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
    
    UITableView *tableSetting = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-10, self.view.frame.size.height-10) style:UITableViewStylePlain];
    
    tableSetting.delegate =self;
    tableSetting.dataSource = self;
    
    [self.view addSubview:tableSetting];
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * cellInde = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellInde];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInde];
    }
    
    return cell;
    
    return nil;
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
