//
//  UIImage+Tool.m
//  dsasdwq
//
//  Created by 朱鑫华 on 2018/9/10.
//  Copyright © 2018年 朱鑫华. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)
+ (instancetype)zxh_imageWithColor:(UIColor *)color{
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, 1)];
    //设置上下文状态
    [color set];
    //添加路径
    CGContextAddPath(ctx, path.CGPath);
    //渲染
    CGContextFillPath(ctx);
    //获取新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return image;
}


//截屏
+ (instancetype)zxh_imageCopyFormView:(UIView *)view{
    NSAssert(view != nil, @"需要截屏的View不可为空！");
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //将view的layer 渲染render到上下文
    [view.layer renderInContext:ctx];
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;

}

//裁剪
+ (instancetype)zxh_imageWithClipRect:(CGRect)rect FromView:(UIView *)view{
    NSAssert(view != nil, @"裁剪的View不可为空！");

    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    //添加裁剪区域
    [path addClip];
//    CGContextAddPath(ctx, path.CGPath);
//    CGContextClip(ctx);
    //绘制图片至上下文
    [view.layer renderInContext:ctx];
    
    UIImage *imageClip = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return  imageClip;
}

//加圆形边框
- (instancetype)zxh_imageWithRoundBorderColor:(UIColor *)color BorderWidth:(CGFloat)borderWidth {
    if (!color) {
        color = [UIColor blackColor];
    }
    CGFloat minWH = self.size.width >= self.size.height ? self.size.height : self.size.width;
    CGFloat ctxWH = minWH + 2 * borderWidth;
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ctxWH, ctxWH), NO, 0);
    //获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ctxWH, ctxWH)];
    //设置ctx填充颜色
    [color set];
    //填充一次背景
    [path fill];
    
    //设置裁剪区
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, minWH, minWH)];
    //添加裁剪区
    [path addClip];
    
    //渲染图片到有背景的CTX上
    [self drawAtPoint:CGPointZero];
    
    UIImage *borderImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return borderImage;
}

//加水印
- (instancetype)zxh_imageWithWatermarkTitle:(NSString *)watermark andFont:(UIFont *)font andColor:(UIColor *)color {
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置水印属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (color) dict[NSForegroundColorAttributeName] = color;
    if (font) dict[NSFontAttributeName] = font;
    //绘制图片
    [self drawAtPoint:CGPointZero];
    //计算水印位置
    CGSize size = [watermark boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGRect rect = CGRectMake(self.size.width - size.width - 10 , self.size.height - size.height -10 , size.width, size.height);
    
    //绘制水印
    [watermark drawInRect:rect withAttributes:dict];
    
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
