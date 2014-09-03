//
//  LionStartViewController.m
//  LionStartEn
//
//  Created by Apple on 14-8-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//


#define OneTableX 130
#define OneTableY 100

#define TableViewDistacew 20

#define TableViewWidth 150
#define TableViewWidth2 270

#define TableViewHeight 500

#import "LionStartViewController.h"
#import "LionTableView.h"
#import "PieChartView.h"
#import "LionStudyViewController.h"
#import "LionSettingViewController.h"

//  初始化

#define Unit @"Unit_1"
#define Class @"class_1"

@interface LionStartViewController ()
{

    LionTableView * lionViewOne;
    LionTableView * lionViewTwo;
    LionTableView * lionViewThree;
    
}

- (IBAction)didClickInfoBtn:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *didMyinfoBtn;

@property (nonatomic,strong)NSDictionary * tempTwoDic;

@property (nonatomic,strong)NSDictionary * tempThreeDic;
@end

@implementation LionStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
self.navigationItem.title = @"我的课程";
    
    CGFloat px = OneTableX;
    CGFloat py = OneTableY;
    
    CGFloat pw = TableViewWidth;
    CGFloat ph = TableViewHeight;
    
    NSString * FilePath = [[NSBundle mainBundle] pathForResource:@"ClassData" ofType:@"plist" inDirectory:nil];
    
    NSDictionary * dicData = [NSDictionary dictionaryWithContentsOfFile:FilePath];
    
    
    self.view.backgroundColor = [[UIColor alloc] initWithRed:240/255.0 green:238/255.0 blue:245/255.0 alpha:1];
    
    //NSLog(@"/////%@",dicData);

    
    /**
       * 初始化选题的界面  是单元的第一个放在里面
     *
     *  @return
     */
    lionViewOne = [[LionTableView alloc] initWithFrame:CGRectMake(px, py, pw, ph) style:UITableViewStylePlain];
    
    lionViewOne.dic = dicData;

    
    [lionViewOne creatDelegate:unitCell];
    
    [self.view addSubview:lionViewOne];
    
    
    px = px + TableViewDistacew + TableViewWidth;
    
    lionViewTwo = [[LionTableView alloc] initWithFrame:CGRectMake(px, py, pw, ph) style:UITableViewStylePlain];
    
    lionViewTwo.dic = [dicData objectForKey:Unit];
    _tempTwoDic =[dicData objectForKey:Unit];
    [lionViewTwo creatDelegate:titleCell];
    
    [self.view addSubview:lionViewTwo];
    
    px = px + TableViewDistacew + TableViewWidth;
    pw = TableViewWidth2;
    
    
    lionViewThree = [[LionTableView alloc] initWithFrame:CGRectMake(px, py, pw, ph) style:UITableViewStylePlain];
    
    lionViewThree.dic = [[dicData objectForKey:Unit] objectForKey:Class];
    _tempThreeDic = [[dicData objectForKey:Unit] objectForKey:Class];
    
    [lionViewThree creatDelegate:imageCell];
    
    [self.view addSubview:lionViewThree];

    /**
     *  三个tableView的点击事件  每次的点击 使得下一级复位
     *
     *  每一个tableView都有一个记录当前的cell 和 row 来进行判断 现在只是1 没有重用问题的kaolv
     *
     *  @return
     */
    
//   点击事件
//  点击第一个
    //NSArray * allkey = [[dicData allKeys] sortedArrayUsingSelector:@selector(comparator)];
    
    LionTableView * liontwo = lionViewTwo;
    LionTableView * lionthree = lionViewThree;
    __block LionStartViewController * startLion = self;
    lionViewOne.didClickBlock = ^(NSString *item){
        
        
        liontwo.oldRowClass = -1;
        NSDictionary * dic = [dicData objectForKey:item];
        
        startLion.tempTwoDic = dic;
        liontwo.dic = dic;
        lionthree.dic = [dic objectForKey:Class];

        [liontwo reloadData];
        [lionthree reloadData];
    };
    
//  点击第二个
    
    LionTableView * lionThree = lionViewThree;
    
    lionViewTwo.didClickBlock =^(NSString *item){
    
        NSDictionary * dic = [startLion.tempTwoDic objectForKey:item];

        startLion.tempThreeDic = dic;
        lionThree.dic = dic;
        [lionThree resetCellThree];
        [lionThree reloadData];
        
   
    };
    
//  点击第三个
    
    lionViewThree.didClickBlock = ^(NSString* item){
    
        [lionThree reloadData];
        
        LionStudyViewController * studyVc = [[LionStudyViewController alloc] init];
        [startLion.navigationController pushViewController:studyVc animated:YES];
    
     studyVc.items = [[startLion.tempThreeDic objectForKey:item] objectForKey:@"practice"];
        
    };
    
    

    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickInfoBtn:(id)sender {
    
    LionSettingViewController * setting = [LionSettingViewController alloc];
    
    [self.navigationController pushViewController:setting animated:YES];
    
    
}
@end
