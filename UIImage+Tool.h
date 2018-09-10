//
//  UIImage+Tool.h
//  dsasdwq
//
//  Created by 朱鑫华 on 2018/9/10.
//  Copyright © 2018年 朱鑫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)
//自定义颜色图片
+ (instancetype)zxh_imageWithColor:(UIColor *)color ;

//截屏
+ (instancetype)zxh_imageCopyFormView:(UIView *)view;

//裁剪
+ (instancetype)zxh_imageWithClipRect:(CGRect)rect FromView:(UIView *)view;

//加圆形边框
- (instancetype)zxh_imageWithRoundBorderColor:(UIColor *)color BorderWidth:(CGFloat)width;

//加水印
- (instancetype)zxh_imageWithWatermarkTitle:(NSString *)watermark andFont:(UIFont *)font andColor:(UIColor *)color ;

@end
