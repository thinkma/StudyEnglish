//
//  LionStudyViewController.m
//  LionStartEn
//
//  Created by Apple on 14-8-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionStudyViewController.h"
#import "LionWordLine.h"
#import "LionPicLine.h"
#import "LionPicJudge.h"
#import "LionVoiceJudge.h"
#import "LionVoice.h"

typedef enum{
    
    oneLion,
    twoLion,
    threeLion,
    fourLion
    
    
    
}StyleWord;


@interface LionStudyViewController ()
{

    NSInteger count;
    NSInteger sum;
    LionWordLine * wordLine;
    LionPicLine * picLine;
    LionPicJudge * picJudge;
    LionVoiceJudge * voiceJudge;
    
    NSMutableArray * arrView;
    
    LionVoice * voice;
    
    
}
- (IBAction)previousOne:(id)sender;
- (IBAction)nextOne:(id)sender;
- (IBAction)ShowAnswer:(id)sender;
- (IBAction)submitAnswer:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *showRightAndWrong;


@property (nonatomic,assign) StyleWord style;
@end

@implementation LionStudyViewController

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
    count = 0;
    sum = self.items.count;
    
//    NSDictionary * one = [self.items objectAtIndex:count];
//    arrView = [NSMutableArray array];
//    
//    [self reloadItem:one];

    voice = [[LionVoice alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shwoYes) name:@"right" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNo) name:@"wrong" object:nil];
    // Do any additional setup after loading the view from its nib.
}


- (void)setItems:(NSArray *)items
{


    _items = items;
    
    count = 0;
    sum = self.items.count;
    
    NSDictionary * one = [self.items objectAtIndex:count];
    arrView = [NSMutableArray array];
    
    [self reloadItem:one];
    
}
- (void)shwoYes
{
    _showRightAndWrong.image = [UIImage imageNamed:@"yes"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
     
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
             [voice speakWord:@"right"];        });
        
    });
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextOne:) userInfo:nil repeats:0];
}

- (void)showNo
{
    _showRightAndWrong.image = [UIImage imageNamed:@"no"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
           [voice speakWord:@"wrong"];        });
        
    });
   


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadItem:(NSDictionary *)dic
{
    
    if (arrView.count==1) {
        LionWordLine * view = [arrView lastObject];
        [view removeFromSuperview];
        [arrView removeAllObjects];
    }

    /*
     wordLine PicLine VoiceJudge PicJudge
     */
    if ([[dic objectForKey:@"Tag"] isEqualToString:ObjectStyleOne]) {
        
        NSArray * views = [[NSBundle mainBundle] loadNibNamed:@"LionWordLine" owner:nil options:nil];
        wordLine =[views lastObject];
        
        wordLine.wordOne = [NSMutableArray arrayWithArray:[dic objectForKey:@"wordOne"]];
        wordLine.wordTow = [NSMutableArray arrayWithArray:[dic objectForKey:@"wordTow"]];
        wordLine.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 100);
        
        [self.view addSubview:wordLine];
        
        [arrView addObject:wordLine];
        _style = oneLion;
        
    }if ([[dic objectForKey:@"Tag"] isEqualToString:ObjectStyleTwo]) {
        
        NSArray * views = [[NSBundle mainBundle] loadNibNamed:@"LionPicLine" owner:nil options:nil];
        picLine =[views lastObject];
        
        picLine.wordOne = [NSMutableArray arrayWithArray:[dic objectForKey:@"wordOne"]];
        picLine.wordTow = [NSMutableArray arrayWithArray:[dic objectForKey:@"wordTow"]];
        picLine.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 100);
        
        [self.view addSubview:picLine];
        
        [arrView addObject:picLine];
        _style = twoLion;
        
    }if ([[dic objectForKey:@"Tag"] isEqualToString:ObjectStyleThree]) {
        NSArray * views = [[NSBundle mainBundle] loadNibNamed:@"LionVoiceJudge" owner:nil options:nil];
        voiceJudge =[views lastObject];
        
        voiceJudge.wordOne = [NSMutableArray arrayWithArray:[dic objectForKey:@"voice"]];
        voiceJudge.words = [dic objectForKey:@"imagePic"];
        voiceJudge.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 100);
        
        [self.view addSubview:voiceJudge];
        
        [arrView addObject:voiceJudge];
        _style = threeLion;
        
    }if ([[dic objectForKey:@"Tag"] isEqualToString:ObjectStyleFour]) {
       
        NSArray * views = [[NSBundle mainBundle] loadNibNamed:@"LionPicJudge" owner:nil options:nil];
        picJudge =[views lastObject];
        picJudge.wordimage = [dic objectForKey:@"imagePic"];
        picJudge.words = [NSMutableArray arrayWithArray:[dic objectForKey:@"words"]];

        picJudge.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 100);
        
        [self.view addSubview:picJudge];
        
        [arrView addObject:picJudge];
        _style = fourLion;

    }
    
    _showRightAndWrong.image = nil;
}

//  上一个
- (IBAction)previousOne:(id)sender {
    if (count == 0) {
        return;
    }
    count--;
NSDictionary * one = [self.items objectAtIndex:count];
    [self reloadItem:one];
    
}

//  下一个
- (IBAction)nextOne:(id)sender {
    
    if (count ==sum-1) {
        return;
    }
    count++;
    NSDictionary * one = [self.items objectAtIndex:count];
    [self reloadItem:one];
    
    
}

//  展示答案
- (IBAction)ShowAnswer:(id)sender {
    
    if (self.style == oneLion) {
        [wordLine removeAllLine];
        [wordLine showrightLine];
    }if (self.style ==twoLion) {
        [picLine showAnswer];
    }if (self.style == threeLion) {
        
    }if(self.style == fourLion){
        [picJudge shwoAnswer];
        
    }

}

//  提交答案
- (IBAction)submitAnswer:(id)sender {
}
@end
