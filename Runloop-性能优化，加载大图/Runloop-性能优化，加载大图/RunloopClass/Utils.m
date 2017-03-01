//
//  Utils.m
//  Runloop-性能优化，加载大图
//
//  Created by codepgq on 2017/3/1.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIImageView*)createImageWithFrame:(CGRect)frame tag:(NSInteger)tag{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.tag = tag;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"spaceship" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    return imageView;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame tag:(NSInteger)tag text:(NSString *)text textColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:13];
    label.tag = tag;
    label.numberOfLines = 0;
    return label;
}

@end
