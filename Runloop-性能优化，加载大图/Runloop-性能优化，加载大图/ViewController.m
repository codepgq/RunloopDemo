//
//  ViewController.m
//  Runloop-性能优化，加载大图
//
//  Created by codepgq on 2017/2/28.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "ViewController.h"
/*
 思想：
 1 加载图片的代码保存起来，不要直接执行，用一个数组保存
    block
 2 监听我们的Runloop循环
    CFRunloop CFRunloopObserver
 3 每次Runloop循环就让它从数组里面去一个加载图片等任务出来执行
 */

#import "PQRunloop.h"
#import "Utils.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

static NSString * const CellIdentifier = @"CellIdentifier";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //提前注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[PQRunloop shareInstance] removeAllTasks];
}

#pragma MARK - Talbeview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //先赋值将要显示的indexPath
    cell.willShowIndexpath = indexPath;
    
    //先移除
    for (NSInteger i = 1; i <= 5; i++) {
        [[cell.contentView viewWithTag:i] removeFromSuperview];
    }
    //添加文字
    [ViewController addLabel:cell indexPath:indexPath];
    
#if 0 //是否开启Runloop优化
    
    // 使用优化
    [[PQRunloop shareInstance] addTask:^BOOL{
        if (![cell.willShowIndexpath isEqual:indexPath]) {
            return NO;
        }
        [ViewController addCenterImg:cell];
        return YES;
    } withId:indexPath];
    
    [[PQRunloop shareInstance] addTask:^BOOL{
        if (![cell.willShowIndexpath isEqual:indexPath]) {
            return NO;
        }
        [ViewController addRightImg:cell];
        return YES;
    } withId:indexPath];
    
    [[PQRunloop shareInstance] addTask:^BOOL{
        if (![cell.willShowIndexpath isEqual:indexPath]) {
            return NO;
        }
        [ViewController addLeftImg:cell indexPath:indexPath];
        return YES;
    } withId:indexPath];
#else
    // 不使用优化
    [ViewController addCenterImg:cell];
    [ViewController addRightImg:cell];
    [ViewController addLeftImg:cell indexPath:indexPath];
    
#endif
    return cell;
}


/**
 添加View到ContentView中，使用CoreAnimation动画

 @param cell cell
 @param view 需要加入的View
 */
+ (void)addViewWith:(UITableViewCell *)cell view:(UIView *)view{
    [UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [cell.contentView addSubview:view];
    } completion:^(BOOL finished) {
    }];
}


/**
 创建一个Label

 @param cell cell
 @param indexPath 用来拼接
 */
+ (void)addLabel:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    NSString * text = [NSString stringWithFormat:@"%zd - Runloop性能优化：一次绘制一张图片。", indexPath.row];
    UILabel *label = [Utils createLabelWithFrame:CGRectMake(5, 5, 300, 25) tag:1 text:text textColor:[UIColor orangeColor]];
    
    [cell.contentView addSubview:label];
}


/**
 添加中间图片

 @param cell cell
 */
+ (void)addCenterImg:(UITableViewCell *)cell{
    UIImageView *imageView = [Utils createImageWithFrame:CGRectMake(105, 20, 85, 85) tag:2];
    [self addViewWith:cell view:imageView];
}


/**
 添加右边图片

 @param cell cell
 */
+ (void)addRightImg:(UITableViewCell *)cell{
    UIImageView *imageView = [Utils createImageWithFrame:CGRectMake(200, 20, 85, 85) tag:3];
    [self addViewWith:cell view:imageView];
}


/**
 添加左边图片和 label

 @param cell cell
 @param indexPath 用来拼接字符串使用
 */
+ (void)addLeftImg:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath  {
    NSString *text = [NSString stringWithFormat:@"%zd - 在Runloop中一次循环绘制所有的点，这里显示加载大图，使得绘制的点增多，从而导致Runloop的点一次循环时间增长，从而导致UI卡顿。", indexPath.row];
    
    UILabel *label = [Utils createLabelWithFrame:CGRectMake(5, 99, [UIScreen mainScreen].bounds.size.width - 10, 50) tag:4 text:text textColor:[UIColor colorWithRed:0.2 green:100.f/255.f blue:0 alpha:1]];
    
    UIImageView *imageView = [Utils createImageWithFrame:CGRectMake(5, 20, 85, 85) tag:5];
    [self addViewWith:cell view:label];
    [self addViewWith:cell view:imageView];
}

@end
