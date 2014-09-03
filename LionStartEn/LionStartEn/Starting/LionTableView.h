//
//  LionTableView.h
//  LionStartEn
//
//  Created by Apple on 14-8-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FinishedDidSelect) (NSString *);

typedef enum {
    
    //以下是枚举成员 TestA = 0,
    
    imageCell,
    titleCell,
    unitCell
    
}StyleCell;

@interface LionTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSDictionary * dic;

@property (nonatomic,copy)FinishedDidSelect didClickBlock;


@property (nonatomic,assign)  NSInteger oldRowClass;

- (void)creatDelegate:(StyleCell)cellStyle;

- (void)resetCellThree;


@end
