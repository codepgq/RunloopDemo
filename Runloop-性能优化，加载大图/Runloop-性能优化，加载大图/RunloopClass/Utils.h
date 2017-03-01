//
//  Utils.h
//  Runloop-性能优化，加载大图
//
//  Created by codepgq on 2017/3/1.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Utils : NSObject

/**
 创建ImageView的工厂

 @param frame 大小位置
 @param tag tag值，用于移除
 @return UIImageView
 */
+ (UIImageView*)createImageWithFrame:(CGRect)frame tag:(NSInteger)tag;


/**
 创建Label的工厂

 @param frame 大小位置
 @param tag tag值，用于移除
 @param text 文本内容
 @param color 文本颜色
 @return UILabel
 */
+ (UILabel *)createLabelWithFrame:(CGRect)frame tag:(NSInteger)tag text:(NSString *)text textColor:(UIColor *)color;
@end
