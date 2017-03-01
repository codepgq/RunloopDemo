//
//  PQRunloop.h
//  Runloop-性能优化，加载大图
//
//  Created by codepgq on 2017/3/1.
//  Copyright © 2017年 pgq. All rights reserved.
//

/*
 为什么要优化：
    Runloop会在一次循环中绘制屏幕上所有的点，如果加载的图片过大，过多，就会造成需要绘制很多的
的点，导致一次循环的时间过长，从而导致UI卡顿。
 */

#import <UIKit/UIKit.h>
#import "PQSingle.h"
typedef BOOL(^RunloopBlock)(void);
@interface PQRunloop : NSObject
PQSINGLE_H(Instance)
//最大任务加载数 默认18(这里主要看屏幕能显示最多少个图片来确定)
@property (nonatomic,assign) NSUInteger maxQueue;
//添加任务
- (void)addTask:(RunloopBlock)unit withId:(id)key;
//移除所有任务
- (void)removeAllTasks;
@end


//动态添加属性
@interface UITableViewCell (PQRunloop)

@property (nonatomic, strong) NSIndexPath *willShowIndexpath;

@end
