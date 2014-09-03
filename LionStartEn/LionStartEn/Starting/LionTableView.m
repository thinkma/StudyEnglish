//
//  LionTableView.m
//  LionStartEn
//
//  Created by Apple on 14-8-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "LionTableView.h"
#import "LionThridTableViewCell.h"
#import "PieChartView.h"


@interface LionTableView ()
{

    StyleCell  cellstyle;
    NSArray * _allKeyArr;
    NSInteger oldRow;
    NSInteger oldRowUnit;
    LionThridTableViewCell * oldCell;
    UITableViewCell * unitCells;
    UITableViewCell * classCell;
    BOOL islock;
    
}
@end


@implementation LionTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)creatDelegate:(StyleCell)cellStyle
{

    cellstyle = cellStyle;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.scrollEnabled = NO;
    if (cellstyle == imageCell) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        islock = NO;
    
    }else{
    
        
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,1)];
        v.backgroundColor = [UIColor lightGrayColor];
        
        [self setTableFooterView:v];
    }

    
    oldRow = -1;
    oldRowUnit = -1;
    self.oldRowClass = -1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return [self.dic allValues].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (cellstyle == imageCell) {
        static NSString * cellIndety = @"cellImage";
        
        LionThridTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndety];
        
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LionThridTableViewCell" owner:self options:nil] lastObject];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!islock) {
            cell.isSelect = NO;
            islock = YES;
        }
        NSArray * arr = [[self.dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        _allKeyArr = [[self.dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        cell.rows = indexPath.row;
        cell.dic = [self.dic objectForKey:[arr objectAtIndex:indexPath.row]];
         return (UITableViewCell *)cell;
        
    }else{
        
        static NSString * cellIndety = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndety];
        
        if (!cell) {
            if(cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        _allKeyArr = [[self.dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        cell.textLabel.text = [_allKeyArr objectAtIndex:indexPath.row];
        return (UITableViewCell *)cell;
    
    }
    
}


- (void)resetCellThree
{

    if (oldCell) {
        oldCell.isSelect = NO;
    }
    oldRow = -1;
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (cellstyle == imageCell) {
        
        if (oldRow!=indexPath.row) {
            if (oldCell) {
            oldCell.isSelect = NO;
            }
            LionThridTableViewCell * cell = (LionThridTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.isSelect = YES;
            oldRow=indexPath.row;
            oldCell = nil;
            oldCell = cell;
        }
        if (_didClickBlock) {
            _didClickBlock ([_allKeyArr objectAtIndex:indexPath.row]);
        }
    }if (cellstyle == unitCell) {
        if (oldRowUnit!=indexPath.row) {
            UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

            if (unitCells) {
            unitCells.textLabel.textColor = [UIColor blackColor];
            oldRowUnit = indexPath.row;

            }
            unitCells = cell;
            cell.textLabel.textColor = [UIColor redColor];
        }
                oldRow = -1;
        if (_didClickBlock) {
            _didClickBlock ([_allKeyArr objectAtIndex:indexPath.row]);
        }
        
    }if (cellstyle ==titleCell) {
        
        if (self.oldRowClass != indexPath.row) {
            UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            if (classCell) {
                classCell.textLabel.textColor = [UIColor blackColor];
                self.oldRowClass  = indexPath.row;

            }
            classCell = cell;
            cell.textLabel.textColor = [UIColor redColor];
        }
        if (_didClickBlock) {
            _didClickBlock ([_allKeyArr objectAtIndex:indexPath.row]);
        }

}
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (cellstyle == imageCell) {
    
        return 45;
    }
    return 40;
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
